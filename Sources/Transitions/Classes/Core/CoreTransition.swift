//
// transitions
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit

// MARK: - CoreTransition

/// A core transition class.
/// Provides functionality for handling custom view controller transitions.
open class CoreTransition: NSObject, ICoreTransition {
    // MARK: Properties

    /// The duration of the transition animation, measured in seconds.
    public let animationDuration: TimeInterval

    /// A flag indicating whether the transition is for presenting (`true`) or dismissing (`false`) a view controller.
    public private(set) var isPresenting = false

    /// The view controller that is presenting the view controller in the presented parameter.
    public private(set) weak var presentingViewController: UIViewController?
    /// The view controller object that is about to be presented onscreen.
    public private(set) weak var presentedViewController: UIViewController?

    /// The context object containing information about the transition.
    public private(set) weak var transitionContext: UIViewControllerContextTransitioning?
    /// This is the target view controller that will be presented after the transition.
    public private(set) weak var toViewController: UIViewController?
    /// This is the currently visible view controller before the transition begins.
    public private(set) weak var fromViewController: UIViewController?
    /// Determine if the transition is interactive.
    public private(set) var isInteractive = false

    /// The source view controller.
    weak var owningController: UIViewController?

    /// The container view serves as the parent view that holds both the from-view and to-view during the transition.
    public private(set) weak var transitionContainerView: UIView?

    /// An object that drives an interactive animation between one view controller and another.
    private var interactionController: UIPercentDrivenInteractiveTransition?

    // MARK: Initialization

    /// Initializes a new instance of the `CustomTransition` class.
    ///
    /// - Parameter animationDuration: The duration of the transition animation, measured in seconds.
    public init(animationDuration: TimeInterval) {
        self.animationDuration = animationDuration
    }

    // MARK: ICoreTransition

    open func performTransition() {}

    open func performDismissTransition() {}

    // MARK: Public

    open func prepareForTransition(interactive _: Bool) {}

    // MARK: Internal

    func prepareTransitionParameters() {}

    /// Completes the current transition and cleans up the transition state.
    ///
    /// - Parameter completion: An optional closure called with a Boolean value
    ///   indicating whether the transition was successful (`true`) or cancelled (`false`).
    @MainActor
    open func completeTransaction(completion: ((Bool) -> Void)? = nil) {
        guard let transitionContext else {
            completion?(false)
            return
        }

        let isFinished = !transitionContext.transitionWasCancelled

        completion?(isFinished)

        transitionContext.completeTransition(isFinished)

        self.transitionContext = nil
        presentedViewController = nil
        presentingViewController = nil
    }
}

// MARK: IInteractiveTransition

extension CoreTransition: IInteractiveTransition {
    public func beginInteractiveDismissalTransition() {
        interactionController = UIPercentDrivenInteractiveTransition()
        owningController?.dismiss(animated: true)
    }

    public func updateInteractiveTransitionToProgress(progress: CGFloat) {
        interactionController?.update(progress)
    }

    public func cancelInteractiveTransition() {
        interactionController?.completionSpeed = 0.999
        interactionController?.cancel()

        interactionController = nil
    }

    public func finishInteractiveTransition() {
        interactionController?.finish()
        interactionController = nil
    }
}

// MARK: UIViewControllerAnimatedTransitioning

extension CoreTransition: UIViewControllerAnimatedTransitioning {
    open func transitionDuration(using _: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        animationDuration
    }

    open func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        fromViewController = transitionContext.viewController(forKey: .from)
        toViewController = transitionContext.viewController(forKey: .to)
        isInteractive = transitionContext.isInteractive
        transitionContainerView = transitionContext.containerView

        prepareTransitionParameters()

        prepareForTransition(interactive: isInteractive)

        if isPresenting {
            performTransition()
        } else {
            performDismissTransition()
        }
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension CoreTransition: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source _: UIViewController
    ) -> (any UIViewControllerAnimatedTransitioning)? {
        presentingViewController = presenting
        presentedViewController = presented
        isPresenting = true
        return self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentingViewController = dismissed
        presentedViewController = dismissed.presentingViewController
        isPresenting = false
        return self
    }

    open func presentationController(
        forPresented _: UIViewController,
        presenting _: UIViewController?,
        source _: UIViewController
    ) -> UIPresentationController? {
        nil
    }
}
