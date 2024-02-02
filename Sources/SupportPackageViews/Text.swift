import SwiftUI

public struct Text: View {
    
    public enum Size: Double {
        case small = 13
        case normal = 15
        case large = 17
    }
    
    let text: String
    let size: Size
    let weight: Font.Weight
    
    @ViewBuilder public var body: some View {
        if text.isEmpty == false {
            SwiftUI.Text(text)
                .font(.designFont(size: size, weight: weight))
        }
    }
    
    public init(_ text: String, size: Size = .normal, weight: Font.Weight = .regular) {
        self.text = text
        self.size = size
        self.weight = weight
    }
}

#Preview {
    PreviewWrapper {
        Text("Hello world")
    }
}
