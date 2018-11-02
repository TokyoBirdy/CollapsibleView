//
//  UIButton+Stylable.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

extension UIButton: Styleable {
    func apply(style: ButtonStyle) {
        self.setTitleColor(style.titleColor, for: .normal)
    }
}

