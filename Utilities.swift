//
//  Utility.swift
//  StretchyView
//
//  Created by ceciliah on 10/25/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(forConstraints: Bool) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = forConstraints
    }
}

func constrain(view:UIView, within container:UIView, insets:UIEdgeInsets) -> [NSLayoutConstraint] {
    let constraints: [NSLayoutConstraint] = [
        view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
        view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -insets.right),
        view.topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
        view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: insets.bottom)
    ]

    return constraints
}

extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }

}


extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomCharacters = (0..<length).map { _ in base.randomElement()!}
        return String(randomCharacters)
    }
}

