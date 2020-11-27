//
//  UIImage+Blur.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

extension UIImage {
    
    func blur(amount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: self) else {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(amount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else {
            return nil
        }
        
        return UIImage(ciImage: outputImage)
    }
    
}
