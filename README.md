<h1 align="center" style="margin-top: 0px;">transitions</h1>

<p align="center">
<a href="https://github.com/space-code/transitions/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/space-code/transitions?style=flat"></a> 
<a href="https://swiftpackageindex.com/space-code/transitions"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Ftransitions%2Fbadge%3Ftype%3Dswift-versions"/></a> 
<a href="https://swiftpackageindex.com/space-code/transitions"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Ftransitions%2Fbadge%3Ftype%3Dplatforms"/></a> 
<a href="https://github.com/space-code/transitions"><img alt="CI" src="https://github.com/space-code/transitions/actions/workflows/ci.yml/badge.svg?branch=main"></a>
</p>

## Description
`transitions` is a framework that reduces the hassle of creating custom transitions.

- [Usage](#usage)
- [Requirements](#requirements)
- [Installation](#installation)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Usage

```swift
import Transitions

final class ZoomTransition: CustomTransition {
    // Implementation of the required protocol methods and properties.
}

let viewController = UIViewController()
viewController.customTransition = ZoomTransition()

self.present(viewController, animated: true)
```

## Requirements

- iOS 12.0+
- Xcode 14.0
- Swift 5.7

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but `transitions` does support its use on supported platforms.

Once you have your Swift package set up, adding `transitions` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/space-code/transitions.git", .upToNextMajor(from: "1.0.0"))
]
```

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
transitions is available under the MIT license. See the LICENSE file for more info.
