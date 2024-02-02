import SwiftUI

public struct PreviewWrapper<T: View>: View {

    let content: T
    
    public var body: some View {
        content
    }
    
    public init(@ViewBuilder content: () -> T) {
        Font.registerDesignFonts()
        self.content = content()
    }
}
