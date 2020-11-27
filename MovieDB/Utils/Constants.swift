//
//  Constants.swift
//  MovieDB
//
//  Created by Niu Changming on 25/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static let SSL_HOST = "api.themoviedb.org"
    static let HOST = String(format: "https://%@", SSL_HOST)
    static let API_KEY = "1ee04cdd24bdc8497ec43f739fd3b5a5"
    
    
    static let IS_IPHONE: Bool = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
    static let IS_IPHONE_4: Bool = IS_IPHONE && (Dimension.SCREEN_HEIGHT == 480.0)
    static let IS_IPHONE_5: Bool = IS_IPHONE && (Dimension.SCREEN_HEIGHT == 568.0)
    static let IS_IPHONE_6: Bool = IS_IPHONE && (Dimension.SCREEN_HEIGHT == 667.0)
    static let IS_IPHONE_6PLUS: Bool = IS_IPHONE && (UIScreen.main.nativeScale == 3.0)
    static let IS_IPHONE_X: Bool = IS_IPHONE && (Dimension.SCREEN_HEIGHT == 812.0)
    static let IS_IPHONE_MAX: Bool = IS_IPHONE && (Dimension.SCREEN_HEIGHT > 812.0)
    static let IS_RETINA: Bool = UIScreen.main.scale == 2.0
    
    struct Dimension {
        static let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
        static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
        static let W_RATIO: CGFloat = 1/375.0*SCREEN_WIDTH
        static let H_RATIO: CGFloat = 1/667.0*SCREEN_HEIGHT
        static let MARGIN_NOR: CGFloat = 15.0
        static let MARGIN_LARGE: CGFloat = 20.0
        static let MARGIN_MIDDLE: CGFloat = 8.0
        static let MARGIN_SMALL: CGFloat = 5.0
        static let BORDER_NOR: CGFloat = 2.0
        static let BORDER_THIN: CGFloat = 1.0
        static let BORDER_LIGHT_THIN: CGFloat = 0.5
        static let STATUS_BAR_HEIGHT: CGFloat = Constants.IS_IPHONE_X || Constants.IS_IPHONE_MAX ? 44 : 20
        static let NAV_BAR_HEIGHT: CGFloat = Constants.IS_IPHONE_X || Constants.IS_IPHONE_MAX ? 88 : 64
        static let NAV_STATUS_BAR_HEIGHT: CGFloat = NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT
        static let TAB_BAR_HEIGHT: CGFloat = Constants.IS_IPHONE_X || Constants.IS_IPHONE_MAX ? 49 + 34 : 49
        static let HOME_INDICATOR_HEIGHT: CGFloat = Constants.IS_IPHONE_X || Constants.IS_IPHONE_MAX ? 34 : 0
        static let BOTTOM_MARGE: CGFloat = HOME_INDICATOR_HEIGHT + 44
        static let TOP_SPACE: CGFloat = IS_IPHONE_X ? 24.0 : 0.0
        static let CORNER_SMALL_SIZE: CGFloat = 2
        static let CORNER_SIZE: CGFloat = 4
        static let CORNER_MEDIUM_SIZE: CGFloat = 6
        static let CORNER_LARGE_SIZE: CGFloat = 10
        static let TEXT_SIZE_LARGE: CGFloat = 18.0
        static let TEXT_SIZE_NOR: CGFloat = 16.0
        static let TEXT_SIZE_SMALL: CGFloat = 13.0
        static let TEXT_SIZE_EXTRA_SMALL: CGFloat = 12.0
    }
    
    struct ColorScheme {
        static let whiteColor = "#FFFFFF"
        static let blackColor = "#151515"
        static let orangeColor = "#EB6E1F"
        static let orangeLightColor = "#E68345"
        static let redColor = "#FF221E"
        static let redLightColor = "#FC504D"
        static let blueColor = "#0297e9"
        static let blueLightColor = "#2FA3E3"
        static let blueExtraLight = "#ABE0FD"
        static let greenColor = "#28df99"
        static let greenLightColor = "#99f3bd"
        static let greenExtraLightColor = "#C6FADB"
        static let grayColor = "#BBBBBB"
        static let lightGrayColor = "#F2F2F6"
        static let extraGrayColor = "#F0F0F0"
        static let purpleColor = "#781D7E"
        static let purpleLightColor = "#8FA1F1"
        static let yellowColor = "#FCE205"
    }
}


