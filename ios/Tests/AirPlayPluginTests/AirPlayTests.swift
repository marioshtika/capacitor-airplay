import XCTest
import UIKit
@testable import AirPlayPlugin

final class AirPlayTests: XCTestCase {
    @MainActor
    func testIsAvailableRequiresAnAttachedWindow() {
        let implementation = AirPlay()

        XCTAssertFalse(implementation.isAvailable(from: nil))

        let viewController = UIViewController()
        _ = viewController.view
        XCTAssertFalse(implementation.isAvailable(from: viewController))

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        XCTAssertTrue(implementation.isAvailable(from: viewController))

        implementation.cleanup()
        window.isHidden = true
    }

    @MainActor
    func testShowFailsWithoutAnActiveViewController() {
        let expectation = expectation(description: "show completion")
        let implementation = AirPlay()

        implementation.show(from: nil) { result in
            switch result {
            case .success:
                XCTFail("show() should fail when there is no active iOS view controller.")
            case .failure(let error):
                XCTAssertEqual(error, .presentationUnavailable)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
