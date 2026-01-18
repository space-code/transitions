# Contributing to Transitions

First off, thank you for considering contributing to Transitions! It's people like you that make Transitions such a great tool.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
  - [Development Setup](#development-setup)
  - [Project Structure](#project-structure)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Documentation](#improving-documentation)
  - [Submitting Code](#submitting-code)
- [Development Workflow](#development-workflow)
  - [Branching Strategy](#branching-strategy)
  - [Commit Guidelines](#commit-guidelines)
  - [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
  - [Swift Style Guide](#swift-style-guide)
  - [Code Quality](#code-quality)
  - [Testing Requirements](#testing-requirements)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to nv3212@gmail.com.

## Getting Started

### Development Setup

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/transitions.git
   cd transitions
   ```

3. **Set up the development environment**
   ```bash
   # Bootstrap the project
   make bootstrap
   ```

4. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

5. **Open the project in Xcode**
   ```bash
   open Package.swift
   ```

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check the [existing issues](https://github.com/space-code/transitions/issues) to avoid duplicates.

When creating a bug report, include:

- **Clear title** - Describe the issue concisely
- **Reproduction steps** - Detailed steps to reproduce the bug
- **Expected behavior** - What you expected to happen
- **Actual behavior** - What actually happened
- **Environment** - iOS version, Xcode version, Swift version
- **Code samples** - Minimal reproducible example
- **Error messages** - Complete error output if applicable

**Example:**
```markdown
**Title:** Custom transition not triggering on dismissal

**Steps to reproduce:**
1. Create CustomTransition subclass with custom dismissal animation
2. Assign transition to view controller using customTransition property
3. Present view controller
4. Dismiss view controller

**Expected:** Custom dismissal animation should play
**Actual:** Default dismissal animation is used instead

**Environment:**
- iOS 16.0
- Xcode 15.3
- Swift 5.10

**Code:**
```swift
final class FadeTransition: CustomTransition {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        // Custom animation code
    }
}

let vc = UIViewController()
vc.customTransition = FadeTransition()
present(vc, animated: true)
dismiss(animated: true) // Uses default animation instead of custom
```
```

### Suggesting Features

We love feature suggestions! When proposing a new feature, include:

- **Problem statement** - What problem does this solve?
- **Proposed solution** - How should it work?
- **Alternatives** - What alternatives did you consider?
- **Use cases** - Real-world scenarios
- **API design** - Example code showing usage
- **Breaking changes** - Will this break existing code?

**Example:**
```markdown
**Feature:** Add interactive transition support

**Problem:** Current implementation doesn't support interactive (gesture-driven) transitions, limiting use cases for custom dismissal gestures.

**Solution:** Add `InteractiveTransition` protocol and gesture recognizer integration to enable swipe-to-dismiss and other interactive transitions.

**API:**
```swift
final class SwipeDismissTransition: CustomTransition, InteractiveTransition {
    var percentComplete: CGFloat = 0
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        self.percentComplete = percentComplete
    }
    
    func finishInteractiveTransition() {
        // Complete transition
    }
    
    func cancelInteractiveTransition() {
        // Cancel and return to original state
    }
}

let vc = UIViewController()
vc.customTransition = SwipeDismissTransition()
vc.customTransition?.enableInteractiveGesture(.swipeDown)
```

**Use case:** Modal views that can be dismissed by swiping down, similar to native iOS modal presentations.
```

### Improving Documentation

Documentation improvements are always welcome:

- **Code comments** - Add/improve inline documentation
- **DocC documentation** - Enhance documentation articles
- **README** - Fix typos, add examples
- **Guides** - Write tutorials or how-to guides
- **API documentation** - Document public APIs

### Submitting Code

1. **Check existing work** - Look for related issues or PRs
2. **Discuss major changes** - Open an issue for large features
3. **Follow coding standards** - See [Coding Standards](#coding-standards)
4. **Write tests** - All code changes require tests
5. **Update documentation** - Keep docs in sync with code
6. **Create a pull request** - Use clear description

## Development Workflow

### Branching Strategy

We use a simplified branching model:

- **`main`** - Main development branch (all PRs target this)
- **`feature/*`** - New features
- **`fix/*`** - Bug fixes
- **`docs/*`** - Documentation updates
- **`refactor/*`** - Code refactoring
- **`test/*`** - Test improvements

**Branch naming examples:**
```bash
feature/interactive-transitions
fix/dismissal-animation-timing
docs/add-advanced-examples
refactor/simplify-transition-context
test/add-presentation-tests
```

### Commit Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear, structured commit history.

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style (formatting, no logic changes)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks
- `perf` - Performance improvements

**Scopes:**
- `core` - Core transition logic
- `animation` - Animation implementations
- `delegate` - Transitioning delegate
- `extension` - UIViewController extensions
- `deps` - Dependencies

**Examples:**
```bash
feat(core): add interactive transition support

Implement InteractiveTransition protocol to enable gesture-driven
transitions. Includes percentage-based updates and completion/
cancellation handlers.

Closes #23

---

fix(animation): correct alpha animation timing for fade transition

Fade animations were completing too quickly due to incorrect
duration calculation. Now properly uses transitionDuration
property for consistent timing.

Fixes #45

---

docs(readme): add slide transition example

Add complete example showing implementation of slide-in/slide-out
transition with spring animation and proper frame calculations.

---

test(core): increase coverage for CustomTransition

Add tests for:
- Presentation with nil views
- Dismissal animation completion
- Spring animation parameters
- Context cleanup on completion
```

**Commit message rules:**
- Use imperative mood ("add" not "added")
- Don't capitalize first letter
- No period at the end
- Keep subject line under 72 characters
- Separate subject from body with blank line
- Reference issues in footer

### Pull Request Process

1. **Update your branch**
   ```bash
   git checkout main
   git pull upstream main
   git checkout feature/your-feature
   git rebase main
   ```

2. **Run tests and checks**
   ```bash
   # Run all tests
   swift test
   
   # Check test coverage
   swift test --enable-code-coverage
   ```

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature
   ```

4. **Create pull request**
   - Target the `main` branch
   - Provide clear description
   - Link related issues
   - Include examples if applicable
   - Request review from maintainers

5. **Review process**
   - Address review comments
   - Keep PR up to date with main
   - Squash commits if requested
   - Wait for CI to pass

6. **After merge**
   ```bash
   # Clean up local branch
   git checkout main
   git pull upstream main
   git branch -d feature/your-feature
   
   # Clean up remote branch
   git push origin --delete feature/your-feature
   ```

## Coding Standards

### Swift Style Guide

We follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) and [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

**Key points:**

1. **Naming**
   ```swift
   // ✅ Good
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
   let transitionDuration: TimeInterval
   
   // ❌ Bad
   func animate(_ ctx: UIViewControllerContextTransitioning)
   let duration: Double
   ```

2. **Protocols**
   ```swift
   // ✅ Good - Descriptive protocol names
   protocol ICustomTransitionAnimating {
       func animatePresentation(using context: UIViewControllerContextTransitioning)
       func animateDismissal(using context: UIViewControllerContextTransitioning)
   }
   
   // ❌ Bad
   protocol Animator { }
   ```

3. **Access Control**
   ```swift
   // ✅ Good - Explicit access control
   open class CustomTransition: NSObject {
       public var transitionDuration: TimeInterval = 0.3
       private(set) var isPresenting: Bool = true
       
       open func animateTransition(
           using transitionContext: UIViewControllerContextTransitioning
       ) {
           // Implementation
       }
       
       public func completeTransaction() {
           // Implementation
       }
   }
   ```

4. **Documentation**
   ```swift
   /// A base class for creating custom view controller transitions.
   ///
   /// Subclass `CustomTransition` to create custom presentation and dismissal
   /// animations for view controllers. Override `animateTransition(using:)` to
   /// implement your custom animation logic.
   ///
   /// - Note: Always call `super.animateTransition(using:)` at the beginning
   ///   of your implementation to ensure proper setup.
   ///
   /// - Example:
   /// ```swift
   /// final class FadeTransition: CustomTransition {
   ///     override func animateTransition(
   ///         using transitionContext: UIViewControllerContextTransitioning
   ///     ) {
   ///         super.animateTransition(using: transitionContext)
   ///         
   ///         guard let toView = transitionContext.view(forKey: .to) else {
   ///             transitionContext.completeTransition(false)
   ///             return
   ///         }
   ///         
   ///         // Implement fade animation
   ///     }
   /// }
   /// ```
   open class CustomTransition: NSObject {
       // Implementation
   }
   ```

### Code Quality

- **No force unwrapping** - Use optional binding or guards
- **No force casting** - Use conditional casting
- **No magic numbers** - Use named constants
- **Single responsibility** - One class, one purpose
- **DRY principle** - Don't repeat yourself
- **SOLID principles** - Follow SOLID design

**Example:**
```swift
// ✅ Good
private enum TransitionConstants {
    static let defaultDuration: TimeInterval = 0.3
    static let springDamping: CGFloat = 0.7
    static let springVelocity: CGFloat = 0.5
}

guard let toView = transitionContext.view(forKey: .to) else {
    transitionContext.completeTransition(false)
    return
}

// ❌ Bad
let view = transitionContext.view(forKey: .to)!
if view.frame.width > 0.7 {
    // Magic numbers and force unwrap
}
```

### Testing Requirements

All code changes must include tests following the naming convention: `test_that<action>_when<condition>`

1. **Unit tests** - Test individual components
2. **Integration tests** - Test component interactions
3. **Animation tests** - Test animation behavior
4. **Edge cases** - Test boundary conditions
5. **Error handling** - Test failure scenarios

**Coverage requirements:**
- New code: minimum 80% coverage
- Modified code: maintain or improve existing coverage
- Critical paths: 100% coverage

**Test structure:**
```swift
import XCTest
@testable import Transitions

final class CustomTransitionTests: XCTestCase {
    var sut: CustomTransition!
    var mockTransitionContext: MockTransitionContext!
    
    override func setUp() {
        super.setUp()
        sut = CustomTransition()
        mockTransitionContext = MockTransitionContext()
    }
    
    override func tearDown() {
        sut = nil
        mockTransitionContext = nil
        super.tearDown()
    }
    
    // MARK: - Presentation Tests
    
    func test_thatAnimatesPresentation_whenIsPresentingIsTrue() {
        // Given
        sut.isPresenting = true
        let expectation = expectation(description: "Animation completes")
        
        // When
        sut.animateTransition(using: mockTransitionContext)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertTrue(self.mockTransitionContext.didCompleteTransition)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Dismissal Tests
    
    func test_thatAnimatesDismissal_whenIsPresentingIsFalse() {
        // Given
        sut.isPresenting = false
        let expectation = expectation(description: "Animation completes")
        
        // When
        sut.animateTransition(using: mockTransitionContext)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertTrue(self.mockTransitionContext.didCompleteTransition)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Edge Cases
    
    func test_thatCompletesTransitionWithFailure_whenToViewIsNil() {
        // Given
        sut.isPresenting = true
        mockTransitionContext.toView = nil
        
        // When
        sut.animateTransition(using: mockTransitionContext)
        
        // Then
        XCTAssertTrue(mockTransitionContext.didCompleteTransition)
        XCTAssertFalse(mockTransitionContext.transitionWasSuccessful)
    }
    
    func test_thatUsesCustomDuration_whenDurationIsSet() {
        // Given
        let customDuration: TimeInterval = 0.5
        sut.transitionDuration = customDuration
        
        // When
        let duration = sut.transitionDuration(using: mockTransitionContext)
        
        // Then
        XCTAssertEqual(duration, customDuration)
    }
    
    // MARK: - Animation Behavior Tests
    
    func test_thatAppliesCorrectInitialState_whenPresentationStarts() {
        // Given
        sut.isPresenting = true
        let toView = UIView()
        mockTransitionContext.toView = toView
        
        // When
        sut.animateTransition(using: mockTransitionContext)
        
        // Then
        // Verify initial animation state
        XCTAssertNotNil(toView.layer.animationKeys())
    }
}

// MARK: - Mock Objects

final class MockTransitionContext: NSObject, UIViewControllerContextTransitioning {
    var containerView: UIView = UIView()
    var isAnimated: Bool = true
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    var presentationStyle: UIModalPresentationStyle = .custom
    
    var didCompleteTransition = false
    var transitionWasSuccessful = false
    
    var toView: UIView?
    var fromView: UIView?
    
    func completeTransition(_ didComplete: Bool) {
        didCompleteTransition = true
        transitionWasSuccessful = didComplete
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case .to: return toView
        case .from: return fromView
        default: return nil
        }
    }
    
    // Implement other required protocol methods...
}
```

**Test naming examples:**
```swift
// ✅ Good - Clear, descriptive test names
func test_thatAnimatesPresentation_whenIsPresentingIsTrue()
func test_thatCompletesTransition_whenAnimationFinishes()
func test_thatCallsSuperMethod_whenAnimateTransitionIsCalled()
func test_thatAddsToViewToContainer_whenPresenting()
func test_thatRemovesFromView_whenDismissing()

// ❌ Bad - Vague or unclear
func testAnimation()
func testPresent()
func testThatWorks()
```

## Community

- **Discussions** - Join [GitHub Discussions](https://github.com/space-code/transitions/discussions)
- **Issues** - Track [open issues](https://github.com/space-code/transitions/issues)
- **Pull Requests** - Review [open PRs](https://github.com/space-code/transitions/pulls)

## Recognition

Contributors are recognized in:
- GitHub contributors page
- Release notes
- Project README (for significant contributions)

## Questions?

- Check [existing issues](https://github.com/space-code/transitions/issues)
- Search [discussions](https://github.com/space-code/transitions/discussions)
- Ask in [Q&A discussions](https://github.com/space-code/transitions/discussions/categories/q-a)
- Email the maintainer: nv3212@gmail.com

---

Thank you for contributing to Transitions! 🎉

Your efforts help make this project better for everyone.