# transitions

<h1 align="center" style="margin-top: 0px;">transitions</h1>

<p align="center">
<a href="https://github.com/space-code/transitions/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/space-code/transitions?style=flat"></a> 
<a href="https://swiftpackageindex.com/space-code/transitions"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Ftransitions%2Fbadge%3Ftype%3Dswift-versions"/></a> 
<a href="https://swiftpackageindex.com/space-code/transitions"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Ftransitions%2Fbadge%3Ftype%3Dplatforms"/></a> 
<a href="https://github.com/space-code/transitions"><img alt="CI" src="https://github.com/space-code/transitions/actions/workflows/ci.yml/badge.svg?branch=main"></a>
<a href="https://github.com/apple/swift-package-manager" alt="transitions on Swift Package Manager" title="transitions on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
</p>

## Description
Transitions is a modern, lightweight Swift framework that simplifies the creation of custom view controller transitions for iOS. Built to reduce boilerplate and enhance code clarity, it provides an elegant API for crafting beautiful presentation and dismissal animations with minimal effort.

## Features

✨ **Simple API** - Clean, intuitive interface for custom transitions  
🎨 **Flexible Animations** - Full control over presentation and dismissal  
🎯 **Type-Safe** - Leverages Swift's type system for compile-time safety  
🔧 **Customizable** - Tailor transitions to match your app's unique style  
📱 **iOS Native** - Built specifically for iOS with UIKit best practices  
⚡ **Lightweight** - Minimal footprint with zero dependencies  

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Creating a Custom Transition](#creating-a-custom-transition)
  - [Applying Transitions](#applying-transitions)
- [Common Use Cases](#common-use-cases)
- [Communication](#communication)
- [Documentation](#documentation)
- [Contributing](#contributing)
  - [Development Setup](#development-setup)
- [Author](#author)
- [License](#license)

## Requirements

| Platform  | Minimum Version |
|-----------|----------------|
| iOS       | 12.0+          |
| Xcode     | 15.3+          |
| Swift     | 5.10+           |

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/space-code/transitions.git", from: "1.1.0")
]
```

Or add it through Xcode:

1. File > Add Package Dependencies
2. Enter package URL: `https://github.com/space-code/transitions.git`
3. Select version requirements

## Quick Start

```swift
import Transitions

// Create your custom transition
final class ZoomTransition: CustomTransition {
    // Implement your custom animation logic
}

// Apply it to a view controller
let viewController = UIViewController()
viewController.customTransition = ZoomTransition()

// Present with your custom transition
present(viewController, animated: true)
```

## Usage

### Creating a Custom Transition

Transitions makes it easy to create custom animations by conforming to the `CustomTransition` protocol:

```swift
import Transitions
import UIKit

final class FadeTransition: CustomTransition {
    override func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        
        super.animateTransition(using: transitionContext)
        
        let containerView = transitionContext.containerView
        
        guard let animatingView = isPresenting ?
                transitionContext.view(forKey: .to) :
                    transitionContext.view(forKey: .from)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        if isPresenting {
            animatingView.alpha = 0
            containerView.addSubview(animatingView)
        }
        
        let finalAlpha: CGFloat = isPresenting ? 1.0 : 0.0
        
        UIView.animate(
            withDuration: transitionDuration,
            animations: {
                animatingView.alpha = finalAlpha
            },
            completion: { finished in
                self.completeTransaction()
            }
        )
    }
}
```

### Applying Transitions

Once you've created your custom transition, applying it is straightforward:

```swift
import Transitions

let detailViewController = DetailViewController()
detailViewController.customTransition = FadeTransition()

present(detailViewController, animated: true)
```

## Common Use Cases

### Zoom Transition

```swift
import Transitions
import UIKit

final class ZoomTransition: CustomTransition {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        if isPresenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }
    
    // MARK: - Private Methods
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView

        toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        toView.alpha = 0
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: transitionDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                toView.transform = .identity
                toView.alpha = 1.0
            },
            completion: { _ in
                self.completeTransaction()
            }
        )
    }
    
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        UIView.animate(
            withDuration: transitionDuration,
            animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                fromView.alpha = 0
            },
            completion: { _ in
                self.completeTransaction()
            }
        )
    }
}
```

### Slide Transition

```swift
import Transitions
import UIKit

final class SlideTransition: CustomTransition {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        if isPresenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }
    
    // MARK: - Private Methods
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)

        toView.frame = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                toView.frame = finalFrame
            },
            completion: { _ in
                self.completeTransaction()
            }
        )
    }
    
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                fromView.frame = fromView.frame.offsetBy(dx: fromView.frame.width, dy: 0)
            },
            completion: { _ in
                self.completeTransaction()
            }
        )
    }
}
```

## Communication

- 🐛 **Found a bug?** [Open an issue](https://github.com/space-code/transitions/issues/new)
- 💡 **Have a feature request?** [Open an issue](https://github.com/space-code/transitions/issues/new)
- ❓ **Questions?** [Start a discussion](https://github.com/space-code/transitions/discussions)
- 🔒 **Security issue?** Email nv3212@gmail.com

## Documentation

Comprehensive documentation is available: [Transitions Documentation](https://space-code.github.io/transitions/)

## Contributing

We love contributions! Please feel free to help out with this project. If you see something that could be made better or want a new feature, open up an issue or send a Pull Request.

### Development Setup

Bootstrap the development environment:

```bash
make install
```

## Author

**Nikita Vasilev**
- Email: nv3212@gmail.com
- GitHub: [@ns-vasilev](https://github.com/ns-vasilev)

## License

Transitions is released under the MIT license. See [LICENSE](https://github.com/space-code/transitions/blob/main/LICENSE) for details.

---

<div align="center">

**[⬆ back to top](#transitions)**

Made with ❤️ by [space-code](https://github.com/space-code)

</div>