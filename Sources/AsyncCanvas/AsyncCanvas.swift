import SwiftUI

/**
 A Canvas view for asynchronous rendering 2D images.
 */
public struct AsyncCanvas<Processor: RenderProcessor>: View {
    
    typealias ProcessorTask = RenderTask<Processor.Context>
    
    @State var image: Image?
    
    @State var renderTask: Task<Void, Never>?
    
    private let render: ProcessorTask
    
    private let processor: Processor

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let image { image }
            }
            .onChange(of: render) { newRender in
                render(size: proxy.size, task: render)
            }
            .task {
                render(size: proxy.size, task: render)
            }
        }
    }
    
    func render(size: CGSize, task: ProcessorTask) {
        renderTask?.cancel()
        
        renderTask = Task.detached {
            await render(size: size, task: task)
        }
    }
    
    func render(size: CGSize, task: ProcessorTask) async {
        guard let image = await processor.render(size: size, render: task)
        else {
            return
        }
        guard !Task.isCancelled else {
            return
        }
        await MainActor.run {
            self.image = image
        }
    }
    
}

extension AsyncCanvas where Processor == CGRenderProcessor {
    
    public init(_ render: @Sendable @escaping (Processor.Context, CGSize) async -> Void) {
        self.render = RenderTask(task: render)
        self.processor = CGRenderProcessor()
    }
    
}
