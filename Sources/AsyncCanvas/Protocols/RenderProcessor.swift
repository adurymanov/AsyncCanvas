import SwiftUI
import CoreGraphics

public protocol RenderProcessor {
    
    associatedtype Context
    
    func render(size: CGSize, render: RenderTask<Context>) async -> Image?
    
}
