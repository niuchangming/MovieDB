//
//  GradientView.swift
//  MovieDB
//
//  Created by Niu Changming on 26/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import UIKit

class GradientView: UIView {
    @IBInspectable var bgColor: UIColor = UIColor.black {
        didSet {
            setupView()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    func setupView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [
            bgColor.withAlphaComponent(0).cgColor,
            bgColor.cgColor
        ]
        backgroundColor = .clear
    }
}
