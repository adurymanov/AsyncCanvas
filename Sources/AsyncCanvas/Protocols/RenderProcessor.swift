import SwiftUI
import CoreGraphics

/**
 Protocol describes a processor for rendering `Image` from render `Context`.
 */
public protocol RenderProcessor {
    
    /**
    Type declare a Context for rendering.
     */
    associatedtype Context
    
    /**
     Method produce an `Image` with given size and from given `RenderTask` with `Context`.
     
     If rendering failed empty image should be returned.
     */
    func render(size: CGSize, render: RenderTask<Context>) async -> Image?
    
}
