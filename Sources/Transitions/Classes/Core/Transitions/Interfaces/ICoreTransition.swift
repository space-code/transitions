//
// transitions
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

/// A protocol defining custom transition animations, ensuring that all methods are executed on the main thread.
@MainActor
public protocol ICoreTransition {
    /// Performs the custom presentation transition.
    /// Implement this method to define how the view is presented.
    func performTransition()

    /// Performs the custom dismissal transition.
    /// Implement this method to define how the view is dismissed.
    func performDismissTransition()
}
