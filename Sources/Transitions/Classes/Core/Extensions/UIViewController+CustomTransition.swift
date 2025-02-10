//
// transitions
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit

// MARK: - AssociatedKeys

private enum AssociatedKeys {
    #if swift(>=5.10)
        nonisolated(unsafe) static var customTransitionKey = "CustomAnimationTransitionKey"
    #else
        static var customTransitionKey = "CustomAnimationTransitionKey"
    #endif
}

public extension UIViewController {
    /// A custom transition object associated with the view controller.
    var customTransition: CoreTransition? {
        get {
            withUnsafePointer(to: &AssociatedKeys.customTransitionKey) {
                objc_getAssociatedObject(self, $0) as? CoreTransition
            }
        }
        set {
            self.customTransition?.owningController = nil
            transitioningDelegate = newValue

            if let transition = newValue {
                modalPresentationStyle = .fullScreen
                self.customTransition?.owningController = self
            }

            withUnsafePointer(to: &AssociatedKeys.customTransitionKey) {
                objc_setAssociatedObject(self, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
