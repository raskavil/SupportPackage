import SwiftUI

public struct LargeButton: View {
    
    public struct Style {
        let titleColor: Color
        let backgroundColor: Color
        
        public init(titleColor: Color = .white, backgroundColor: Color = .black) {
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
        }
    }
    
    let title: String
    let action: () -> Void
    let style: Style
    
    public var body: some View {
        Button(action: action) {
            Text(title, weight: .bold)
                .foregroundStyle(style.titleColor)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(style.backgroundColor)
                .frame(minWidth: 120)
        }
    }
    
    public init(_ title: String, action: @escaping () -> Void, style: Style = .init()) {
        self.title = title
        self.action = action
        self.style = style
    }
}

#Preview {
    PreviewWrapper {
        LargeButton("Try again", action: {}, style: .init(backgroundColor: .blue))
    }
}
