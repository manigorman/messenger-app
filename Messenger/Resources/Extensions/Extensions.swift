//
//  Extensions.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import Foundation
import UIKit

extension UIView { // Добавляем поля для упрощения взятия размеров: view.frame.size. -> view.
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var heigth: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
}
