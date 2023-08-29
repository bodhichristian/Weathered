//
//  MorphingImageCL.swift
//  Weathered
//
//  Created by christian on 8/29/23.
//
//  Original File:
//  MorphingImage.swift
//  Morphing
//
//  Created by Jeremy Marchand on 01/10/2022.
//
//

import Foundation

import SwiftUI

/// A Morphing Image that animates when image change.
///
/// When images change, an animation will be performed to morph previous image to the new image. It uses a combinaison of a blur and an alpha threshold effects.
///
/// The morphing image uses a base Image as a the template for the resulting image and applies the current foreground style.
///
/// The animation duration is by default set to 1 second but can be customized through the modifier ``morphingImageDuration(_:)``
///
/// The size of the morphing image is inherited from the container and not the template image.
/// - Parameter duration: Duration of the morphing animate.
public struct MorphingImageCL: View {
    @Environment(\.morphingImageDuration)
    var duration

    /// Creates a morphing image that you can use as symbol for controls.
    ///
    /// - Parameters:
    ///   - name: The name of the image resource to lookup.
    ///   - bundle: The bundle to search for the image resource.
    ///   If `nil`, SwiftUI uses the main `Bundle`. Defaults to `nil`.
    public init(_ name: String, bundle: Bundle? = nil) {
        self.image = Image(name, bundle: bundle).symbolRenderingMode(.multicolor)
        self.name = name
    }

    /// Creates a system symbol morphing image.
    ///
    /// This initializer creates an image using a system-provided symbol. Use
    /// [SF Symbols](https://developer.apple.com/design/resources/#sf-symbols)
    /// to find symbols and their corresponding names.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system symbol image.
    ///     Use the SF Symbols app to look up the names of system symbol images.
    public init(systemName: String) {
        self.image = Image(systemName: systemName)
        self.name = systemName
    }

    let image: Image
    let name: String

    @State
    private var blurRadius: Double = 0

    @State
    private var currentTask: Task<Void, Error>?

    public var body: some View {
        GeometryReader { reader in
            // Adapt blur radius to the size.
            let size = max(reader.size.width, reader.size.height)
            let blurRadius = min(size * 0.05, 20)

            Canvas { context, size  in
                context.clipToLayer { context in
                    context.addFilter(.alphaThreshold(min: 0.5))
                    context.drawLayer { context in
                        let view = context.resolveSymbol(id: 0)!
                        context.draw(view, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .foreground)
            } symbols: {
                symbol(forSize: reader.size).tag(0)
                    
            }
            .onChange(of: image) {
                currentTask?.cancel()
                currentTask = Task {
                    let halfDuration = duration / 2
                    withAnimation(.easeIn(duration: halfDuration)) {
                        self.blurRadius = blurRadius
                    }
                    try await Task.sleep(nanoseconds: UInt64(Int64(duration * 500_000_000)))
                    withAnimation(.easeOut(duration: halfDuration)) {
                        self.blurRadius = 0
                    }
                }
            }
        }
    }

    private func symbol(forSize size: CGSize) -> some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
                .id(name)
        }
        .animation(.easeInOut(duration: duration), value: name)
        .blur(radius: self.blurRadius)
    }
}

// MARK: - Environment
private struct MorphingDurationKey: EnvironmentKey {
    static var defaultValue: Double = 1
}

private extension EnvironmentValues {
    var morphingImageDuration: Double {
        get {
            self[MorphingDurationKey.self]
        } set {
            self[MorphingDurationKey.self] = newValue
        }
    }
}

public extension View {
    func morphingImageDuration(_ value: Double) -> some View {
        self.environment(\.morphingImageDuration, value)
    }
}

// MARK: - Preview
struct MorphingImage_Previews: PreviewProvider {
    static let names = [
        "circle.fill",
        "heart.fill",
        "star.fill",
        "bell.fill",
        "bookmark.fill",
        "tag.fill",
        "bolt.fill",
        "play.fill",
        "pause.fill",
        "squareshape.fill",
        "key.fill",
        "hexagon.fill",
        "gearshape.fill",
    ]

    static var previews: some View {
        TimelineView(.animation(minimumInterval: 2)) { context in
            MorphingImageCL(systemName: names.randomElement()!)
        }
        .foregroundColor(.accentColor)
        .frame(width: 128, height: 128)
        .previewLayout(.fixed(width: 128, height: 128))
    }
}
