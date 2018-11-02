//
//  ViewBinder.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import Foundation
import UIKit

func bind(content:ViewModel, with view: CollapsibleView) {
    view.headerImageView.image = content.image
}

