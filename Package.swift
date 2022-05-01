// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-duckdb",
    products: [
        .library(
            name: "CDuckDB",
            targets: ["CDuckDB"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CDuckDB",
            dependencies: [],
            cxxSettings: [
                .unsafeFlags(["-std=c++11"])
            ]
        ),
        .testTarget(
            name: "CDuckDBTests",
            dependencies: [
                .byName(name: "CDuckDB")
            ]
        )
    ]
)
