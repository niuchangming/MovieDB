//
//  UIFont+Style.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

extension UIFont {

    var bold: UIFont {
        return with(traits: .traitBold)
    }

    var italic: UIFont {
        return with(traits: .traitItalic)
    }

    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    }


    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
          return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

}
