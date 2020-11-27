//
//  EmptyConfig.swift
//  MovieDB
//
//  Created by Niu Changming on 27/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import Foundation
import UIKit

struct EmptyConfig {

    var isLoading = false
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    var loadingTitleString: NSAttributedString? {
        let text: String = "Wait..."
        let font: UIFont = UIFont.init(name: "HelveticaNeue-Medium", size: 15)!
        let textColor: UIColor = UIColor(hexString: Constants.ColorScheme.grayColor)
    
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        return NSAttributedString.init(string: text, attributes: attributes)
    }
    
    
    var loadingDetailString: NSAttributedString? {
        let text: String = "Loading..."
        let font: UIFont = UIFont.systemFont(ofSize: 15.0)
        let textColor: UIColor = UIColor(hexString: Constants.ColorScheme.grayColor)
    
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return NSAttributedString.init(string: text, attributes: attributes)
    }
    
    var emptyTitleString: NSAttributedString? {
        let text: String = "Sorry"
        let font: UIFont = UIFont.init(name: "HelveticaNeue-Medium", size: 15)!
        let textColor: UIColor = UIColor(hexString: Constants.ColorScheme.grayColor)
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        return NSAttributedString.init(string: text, attributes: attributes)
    }
    
    
    var emptyDetailString: NSAttributedString? {
        let text: String = "Oops! We can't find the page you're looking for."
        let font: UIFont = UIFont.systemFont(ofSize: 15.0)
        let textColor: UIColor = UIColor(hexString: Constants.ColorScheme.grayColor)
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return NSAttributedString.init(string: text, attributes: attributes)
    }
    
    var image: UIImage? {
        return UIImage.init(named: "empty_icon")
    }
    
    var imageAnimation: CAAnimation? {
        let animation = CABasicAnimation.init(keyPath: "transform")
        animation.fromValue = NSValue.init(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(.pi/2, 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        
        return animation;
    }
    
    func buttonTitle(_ state: UIControl.State) -> NSAttributedString? {
        let text: String = "Starting"
        let font: UIFont = UIFont.boldSystemFont(ofSize: 16)
        let textColor: UIColor = UIColor(hexString: Constants.ColorScheme.blueColor)
    
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return NSAttributedString.init(string: text, attributes: attributes)
    }
    
    var backgroundColor: UIColor? {
        return .white
    }
    
    var verticalOffset: CGFloat {
        return 0
    }
    
    var spaceHeight: CGFloat {
        return 0
    }
    
}
