import Foundation
import CoreGraphics

public struct RenderTask<Context>: Identifiable, Equatable {
    
    public let id = UUID()
    
    let task: (Context, CGSize) async -> Void
    
    init(task: @Sendable @escaping (Context, CGSize) async -> Void) {
        self.task = task
    }
    
    public static func == (lhs: RenderTask, rhs: RenderTask) -> Bool {
        lhs.id == rhs.id
    }
    
}
