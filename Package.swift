// swift-tools-version:5.3
import PackageDescription

let buildTests = false

let package = Package(
        name: "SwiftUIFormValidator",
        platforms: [
            .macOS(.v11), .iOS(.v14), .tvOS(.v14)
        ],
        products: [
            .library(name: "FormValidator", targets: ["FormValidator"])
        ],
        dependencies: [],
        targets: [
            .target(
                    name: "FormValidator",
                    dependencies: [],
                    path: "Sources",
                    exclude: ["../Tests", "../Example"],
					resources: [
						.copy("Supporting Files")]
			)
        ]
)
