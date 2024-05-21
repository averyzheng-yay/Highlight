//
// FontModifier.swift
// Highlight
//

// Having to type the name every time is error prone and redundant, this is a neat case of improvisation and adds more customisibility
import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

//extension Font {
//    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
//        switch fontType {
//        case .light:
//            Font.custom("Inter-Light", size: size)
//        case .regular:
//            Font.custom("Inter-Regular", size: size)
//        case .medium:
//            Font.custom("Inter-Medium", size: size)
//        case .semiBold:
//            Font.custom("Inter-SemiBold", size: size)
//        case .bold:
//            Font.custom("Inter-Bold", size: size)
//        case .black:
//            Font.custom("Inter-Black", size: size)
//        }
//    }
//}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}


