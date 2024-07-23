import SwiftUI
import SupportPackage

public struct VCollection: Layout {
    
    var horizontalSpacing: CGFloat
    var verticalSpacing: CGFloat
    var horizontalAlignment: HorizontalAlignment
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let subviewFrames = layoutViewsWith(subviews.map { $0.dimensions(in: proposal) }, for: proposal.width)
        return .init(
            width: proposal.width ?? subviewFrames.map(\.maxX).max() ?? 0,
            height: subviewFrames.map(\.maxY).max() ?? 0
        )
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        var layout = layoutViewsWith(subviews.map { $0.dimensions(in: .unspecified) }, for: bounds.width)
        
        if horizontalAlignment == .center || horizontalAlignment == .trailing {
            Set(layout.map(\.origin.y)).forEach { yPosition in
                let frames = layout.enumerated().filter { $0.element.origin.y == yPosition }
                if var correction = frames.map(\.element.maxX).max().map({ bounds.width - $0 }), correction > 0 {
                    if horizontalAlignment == .center {
                        correction /= 2
                    }
                    frames.forEach { index, _ in
                        layout[index].origin.x += correction
                    }
                }
            }
        }
        
        zip(subviews, layout)
            .forEach { subview, frame in
                subview.place(
                    at: .init(x: frame.origin.x + bounds.origin.x, y: frame.origin.y + bounds.origin.y),
                    proposal: .unspecified
                )
            }
    }
    
    private func layoutViewsWith(_ dimensions: [ViewDimensions], for width: CGFloat?) -> [CGRect] {
        guard let width, width != .infinity, width >= dimensions.map(\.width).max() ?? 0 else {
            return dimensions.reduce(into: (currentY: 0.0, frames: [CGRect]())) { partialResult, dimensions in
                partialResult.frames.append(
                    .init(
                        x: 0,
                        y: partialResult.currentY,
                        width: dimensions.width,
                        height: dimensions.height
                    )
                )
                partialResult.currentY += dimensions.height + verticalSpacing
            }.frames
        }
        
        return dimensions.reduce(into: (x: 0.0, y: 0.0, rowHeight: 0.0, frames: [CGRect]())) { partialResult, dimensions in
            if partialResult.x != 0 {
                partialResult.x += horizontalSpacing
            }
            
            if (partialResult.x + dimensions.width) > width {
                partialResult.y += partialResult.rowHeight + verticalSpacing
                partialResult.x = 0
                partialResult.rowHeight = 0
            }
            
            partialResult.frames.append(
                .init(
                    x: partialResult.x,
                    y: partialResult.y,
                    width: dimensions.width,
                    height: dimensions.height
                )
            )
            
            partialResult.x += dimensions.width
            partialResult.rowHeight = max(dimensions.height, partialResult.rowHeight)
        }.frames
    }
    
    public init(
        horizontalSpacing: CGFloat = 12,
        verticalSpacing: CGFloat = 12,
        horizontalAlignment: HorizontalAlignment = .leading
    ) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.horizontalAlignment = horizontalAlignment
    }
}
