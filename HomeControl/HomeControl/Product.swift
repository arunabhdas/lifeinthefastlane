//
//  Product.swift
//  HomeControl
//
//

import UIKit

class Product: NSObject {
    var productNumber: Int?
    var name: String?
    var desc: String?
    var mainImage: UIImage?
    init(productNumber: Int?, name: String?, desc: String?) {
        self.productNumber = productNumber
        self.name = name
        self.desc = desc
        let placeholder = UIImage(named: "logo")
        self.mainImage = placeholder
        
    }
}