//
//  Constants.swift
//
//

import UIKit

struct Constants {
    struct Colors {
        static let colorLightBlue:UIColor = UIColor(red: 5/255.0, green: 102/255.0, blue: 141/255.0, alpha: 100.0/100.0)
        static let colorBlue:UIColor = UIColor(red:  2/255.0, green: 128/255.0, blue: 144/255.0, alpha: 100.0/100.0)
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
    }
    
    struct FontProperties {
        static let kFontName = "Avenir Book"
        static let kFontSize: CGFloat = 21
    }
    struct IconFontProperties {
        static let kFontSize: CGFloat = 21
    }
    
    struct NumItems {
        static let leftMenuNumItems: CGFloat = 9
    }
    
    struct Categories {
        static let kTitleNewArrivals = 0
        static let kTitleDresses = 1
        static let kTitleJackets = 2
        static let kTitleLace = 3
        static let kTitleProm = 4
        static let kTitleSilk = 5
        static let kTitleSkirts = 6
        static let kTitleTops = 7
        static let kTitleBridal = 8
    }
    struct Labels {
        static let kApplicationName = "HomeControl"
        static let kOnOff = "On / Off"
    }
    struct Entities {
        static let kProductClass = "Product"
    }
    struct NotificationKeys {
        static let kLeftMenuNotificationKey = "LeftMenuNotificationKey"
    }
}