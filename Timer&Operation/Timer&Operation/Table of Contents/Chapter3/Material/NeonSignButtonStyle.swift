//
//  ButtonStyle.swift
//  Timer&Operation
//
//  Created by Woody on 2022/3/18.
//

import UIKit

protocol ButtonStylyComponnet {
    static var titleColor: UIColor { get }
    
    static var highlightedColor: UIColor { get }
    
    static var backgroundColor: UIColor { get }
    
    static var flashBackgroundColor: UIColor { get }
}
extension ButtonStylyComponnet {
    
    static func setButton(_ button: UIButton) {
        button.setTitleColor(Self.titleColor, for: .normal)
        button.setTitleColor(Self.highlightedColor, for: .highlighted)
        button.backgroundColor = Self.backgroundColor
    }
    
    static func setFlashColor(_ button: UIButton, isFlash: Bool) {
        guard isFlash else { return }
        button.backgroundColor = Self.flashBackgroundColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Self.setButton(button)
        }
    }
}

extension NeonSignMaterial {

    struct FirstButton: ButtonStylyComponnet {
        static var flashBackgroundColor: UIColor = .green
        
        static var titleColor: UIColor = .black
        
        static var highlightedColor: UIColor = .green.withAlphaComponent(0.1)
        
        static var backgroundColor: UIColor = .green.withAlphaComponent(0.3)
        
        
    }
    
    struct SecondButton: ButtonStylyComponnet {
        static var flashBackgroundColor: UIColor = .yellow
        
        static var titleColor: UIColor = .black
        
        static var highlightedColor: UIColor = .yellow.withAlphaComponent(0.1)
        
        static var backgroundColor: UIColor = .yellow.withAlphaComponent(0.3)
        
    }
    
    struct ThirdButton: ButtonStylyComponnet {
        static var flashBackgroundColor: UIColor = .red
        
        static var titleColor: UIColor = .black
        
        static var highlightedColor: UIColor = .red.withAlphaComponent(0.1)
        
        static var backgroundColor: UIColor = .red.withAlphaComponent(0.3)
        
    }
    
    
}

    
    

