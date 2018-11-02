//
//  Style.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

protocol Style {
}

protocol Styleable {
}

extension Styleable {
    //default implementation
    public func apply<S:Style>(style:S) {
        fatalError("this is a protocol extension")
    }
}

struct ButtonStyle: Style {
    var titleColor: UIColor = UIColor.random
}
