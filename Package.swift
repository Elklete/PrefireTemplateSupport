// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PrefireTemplateSupport",
    products: [
        .library(name: "PathKit", targets: ["PathKit"]),
        .library(name: "Stencil", targets: ["Stencil"]),
        .library(name: "StencilSwiftKit", targets: ["StencilSwiftKit"]),
    ],
    targets: [
        .target(name: "PathKit"),
        .target(
            name: "Stencil",
            dependencies: ["PathKit"]
        ),
        .target(
            name: "StencilSwiftKit",
            dependencies: ["PathKit", "Stencil"]
        ),
        .testTarget(
            name: "StencilSwiftKitTests",
            dependencies: ["StencilSwiftKit", "Stencil", "PathKit"]
        ),
        .testTarget(
            name: "TemplateSupportTests",
            dependencies: ["PathKit", "Stencil", "StencilSwiftKit"]
        ),
    ],
    swiftLanguageModes: [.v5]
)
