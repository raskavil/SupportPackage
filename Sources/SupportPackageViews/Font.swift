import SwiftUI

extension Font {
    
    public static func designFont(size: Text.Size = .normal, weight: Font.Weight = .regular) -> Font {
        switch weight {
            case .black, .heavy:                        return .custom("SourceSans3-Black", size: size.rawValue)
            case .bold, .semibold:                      return .custom("SourceSans3-Bold", size: size.rawValue)
            case .medium:                               return .custom("SourceSans3-Medium", size: size.rawValue)
            case .regular, .thin, .light, .ultraLight:  return .custom("SourceSans3-Regular", size: size.rawValue)
            default:                                    return .custom("SourceSans3-Regular", size: size.rawValue)
        }
    }

    public static func registerDesignFonts() {
        let fontNames = ["SourceSans3-Black", "SourceSans3-Bold", "SourceSans3-Medium", "SourceSans3-Regular"]
        
        fontNames.forEach { name in
            guard let font = Bundle.module.url(forResource: name, withExtension: ".ttf")
                .flatMap({ url in CGDataProvider(url: url as CFURL) })
                .flatMap({ provider in CGFont(provider) })
            else {
                fatalError("Failed to register fonts")
            }
                        
            var error: Unmanaged<CFError>?
            
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
