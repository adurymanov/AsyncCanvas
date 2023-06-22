import CoreGraphics
import SwiftUI
import UIKit

public final actor CGRenderProcessor: RenderProcessor {
    
    public typealias Context = CGContext
    
    public func render(size: CGSize, render: RenderTask<Context>) async -> Image? {
        try? await Self.render(size: size, render: render)
    }

}

private extension CGRenderProcessor {
    
    enum RenderError: Error {
        case taskCanceled
        case uiImageRenderFiled
    }

    static func render(size: CGSize, render: RenderTask<CGContext>) async throws -> Image {
        defer {
            UIGraphicsEndImageContext()
        }
        
        try checkCancelation()
        
        UIGraphicsBeginImageContextWithOptions(size, false, .zero)
        
        try checkCancelation()
        
        let context = UIGraphicsGetCurrentContext()!
        
        try checkCancelation()
        
        await render.task(context, size)
        
        try checkCancelation()
        
        guard let uiImage = UIGraphicsGetImageFromCurrentImageContext() else {
            throw RenderError.uiImageRenderFiled
        }
        
        try checkCancelation()
        
        return Image(uiImage: uiImage)
    }
    
    static func checkCancelation() throws {
        if Task.isCancelled {
            throw RenderError.taskCanceled
        }
    }
    
}
