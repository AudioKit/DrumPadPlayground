// swift-tools-version: 5.5

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Drum Pad",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "Drum Pad",
            targets: ["AppModule"],
            bundleIdentifier: "com.audiokitpro.drumpadplaygrounds",
            teamIdentifier: "9W69ZP8S5F",
            displayVersion: "1.0.1",
            bundleVersion: "3",
            iconAssetName: "AppIcon",
            accentColorAssetName: "AccentColor",
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
