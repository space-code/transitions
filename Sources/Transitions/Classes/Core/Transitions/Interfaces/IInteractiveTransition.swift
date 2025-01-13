//
// transitions
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

/// A protocol defining the behavior for interactive transitions, typically used in custom view controller transitions.
@MainActor
public protocol IInteractiveTransition {
    /// Begins the interactive dismissal transition.
    /// Use this method to initialize the interactive transition process.
    func beginInteractiveDismissalTransition()

    /// Updates the interactive transition to a specific progress.
    ///
    /// - Parameter progress: A value between 0.0 and 1.0 indicating the current progress of the transition.
    func updateInteractiveTransitionToProgress(progress: CGFloat)

    /// Cancels the interactive transition.
    /// Use this method to revert any changes made during the transition and restore the original state.
    func cancelInteractiveTransition()

    /// Completes the interactive transition.
    /// Use this method to finalize the transition and apply the final state.
    func finishInteractiveTransition()
}
