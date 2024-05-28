//
//  UILabel + Extension .swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit


extension CGFloat {
    static var random: CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
           return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
