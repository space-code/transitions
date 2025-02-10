//
// transitions
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit

// MARK: - CustomTransition

/// A custom transition class.
/// Provides functionality for handling custom view controller transitions.
open class CustomTransition: CoreTransition {
    // MARK: Properties

    /// This represents the view's transformation state before the transition begins.
    public private(set) var intitialTransform: CGAffineTransform?
    /// This represents the view's transformation state after the transition is completed.
    public private(set) var finalTransform: CGAffineTransform?

    // MARK: Internal

    override func prepareTransitionParameters() {
        guard let toViewController,
              let fromViewController,
              let transitionContext,
              let presentingViewController,
              let presentedViewController
        else {
            completeTransaction()
            return
        }

        if isPresenting {
            transitionContainerView?.addSubview(toViewController.view)
            transitionContainerView?.addSubview(fromViewController.view)

            intitialTransform = presentingViewController.view.transform
            finalTransform = presentedViewController.view.transform

            presentingViewController.view.frame = transitionContext.initialFrame(for: presentingViewController)
        } else {
            transitionContainerView?.addSubview(fromViewController.view)
            transitionContainerView?.addSubview(toViewController.view)

            intitialTransform = presentedViewController.view.transform
            finalTransform = presentingViewController.view.transform

            presentingViewController.view.frame = transitionContext.finalFrame(for: presentingViewController)
        }
    }
}
