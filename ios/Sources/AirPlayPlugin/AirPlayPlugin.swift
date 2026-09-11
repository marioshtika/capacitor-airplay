import Foundation
import Capacitor

@objc(AirPlayPlugin)
public class AirPlayPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AirPlayPlugin"
    public let jsName = "AirPlay"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "show", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "isAvailable", returnType: CAPPluginReturnPromise)
    ]

    private let implementation = AirPlay()

    @objc func show(_ call: CAPPluginCall) {
        implementation.show(from: bridge?.viewController) { result in
            switch result {
            case .success:
                call.resolve()
            case .failure(let error):
                call.reject(error.localizedDescription)
            }
        }
    }

    @objc func isAvailable(_ call: CAPPluginCall) {
        let resolveAvailability = {
            call.resolve([
                "available": self.implementation.isAvailable(from: self.bridge?.viewController)
            ])
        }

        if Thread.isMainThread {
            resolveAvailability()
        } else {
            DispatchQueue.main.async(execute: resolveAvailability)
        }
    }
}
