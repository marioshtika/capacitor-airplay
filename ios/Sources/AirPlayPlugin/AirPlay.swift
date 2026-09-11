import Foundation
import AVKit
import UIKit

enum AirPlayError: LocalizedError, Equatable {
    case pickerAlreadyActive
    case presentationUnavailable
    case pickerButtonUnavailable

    var errorDescription: String? {
        switch self {
        case .pickerAlreadyActive:
            return "The AirPlay picker is already being presented."
        case .presentationUnavailable:
            return "AirPlay picker could not be presented because no active iOS view is available."
        case .pickerButtonUnavailable:
            return "AirPlay picker could not be opened using the current iOS route picker configuration."
        }
    }
}

@objc public class AirPlay: NSObject {
    private var activeRoutePickerView: AVRoutePickerView?
    private var cleanupWorkItem: DispatchWorkItem?

    public override init() {
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleApplicationDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        cleanup()
    }

    public func isAvailable(from viewController: UIViewController?) -> Bool {
        guard let viewController else {
            return false
        }

        _ = viewController.view
        return viewController.view.window != nil
    }

    public func show(from viewController: UIViewController?, completion: @escaping (Result<Void, AirPlayError>) -> Void) {
        let presentPicker = {
            guard let viewController else {
                completion(.failure(.presentationUnavailable))
                return
            }

            _ = viewController.view

            guard viewController.view.window != nil else {
                completion(.failure(.presentationUnavailable))
                return
            }

            guard self.activeRoutePickerView == nil else {
                completion(.failure(.pickerAlreadyActive))
                return
            }

            let routePickerView = AVRoutePickerView(frame: CGRect(x: -1000, y: -1000, width: 1, height: 1))
            routePickerView.alpha = 0.01
            routePickerView.tintColor = .clear
            routePickerView.activeTintColor = .clear
            routePickerView.prioritizesVideoDevices = false

            viewController.view.addSubview(routePickerView)
            routePickerView.setNeedsLayout()
            routePickerView.layoutIfNeeded()

            guard let routePickerButton = self.findRoutePickerControl(in: routePickerView) else {
                routePickerView.removeFromSuperview()
                completion(.failure(.pickerButtonUnavailable))
                return
            }

            self.activeRoutePickerView = routePickerView
            routePickerButton.sendActions(for: .touchUpInside)
            self.scheduleCleanup()
            completion(.success(()))
        }

        if Thread.isMainThread {
            presentPicker()
        } else {
            DispatchQueue.main.async(execute: presentPicker)
        }
    }

    @objc private func handleApplicationDidEnterBackground() {
        cleanup()
    }

    func cleanup() {
        cleanupWorkItem?.cancel()
        cleanupWorkItem = nil
        activeRoutePickerView?.removeFromSuperview()
        activeRoutePickerView = nil
    }

    private func scheduleCleanup() {
        cleanupWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            self?.cleanup()
        }

        cleanupWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
    }

    private func findRoutePickerControl(in view: UIView) -> UIControl? {
        if let control = view as? UIControl {
            return control
        }

        for subview in view.subviews {
            if let control = findRoutePickerControl(in: subview) {
                return control
            }
        }

        return nil
    }
}
