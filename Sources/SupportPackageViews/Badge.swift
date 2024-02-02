import SwiftUI

public struct Badge: View {
    
    public struct Style {
        let contentColor: Color
        let backgroundColor: Color
        let borderColor: Color
        
        public init(contentColor: Color = .black, backgroundColor: Color = .white, borderColor: Color = .black) {
            self.contentColor = contentColor
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
        }
    }
    
    let text: String
    let icon: Icon.Content?
    let style: Style
    
    public var body: some View {
        HStack(spacing: 4) {
            Icon(icon, size: .small)
                .foregroundStyle(style.contentColor)
            Text(text, size: .small, weight: .bold)
                .foregroundStyle(style.contentColor)
        }
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(style.backgroundColor)
                .border(style.borderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        }
    }
    
    public init(text: String = "", icon: Icon.Content? = nil, style: Style = .init()) {
        self.text = text
        self.icon = icon
        self.style = style
    }
}

#Preview {
    PreviewWrapper {
        Badge(text: "1", icon: .system("tram.fill"), style: .init(contentColor: .white, backgroundColor: .red, borderColor: .clear))
    }
}
