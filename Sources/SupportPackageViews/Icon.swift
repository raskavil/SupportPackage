import SwiftUI

public struct Icon: View {
    
    public enum Size: Double {
        case tiny = 12
        case small = 16
        case normal = 20
        case large = 24
    }
    
    public enum Content {
        case system(String)
        case image(Image)
        
        var image: Image {
            switch self {
                case .image(let image):         return image
                case .system(let systemName):   return .init(systemName: systemName)
            }
        }
    }
    
    let content: Content?
    let size: Size
    
    @ViewBuilder public var body: some View {
        if let content {
            content.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.rawValue, height: size.rawValue)
        }
    }
    
    public init(_ content: Content?, size: Size = .normal) {
        self.content = content
        self.size = size
    }
}

#Preview {
    HStack {
        Icon(.system("bus.fill"))
        Icon(.system("bus"), size: .small)
    }
}
