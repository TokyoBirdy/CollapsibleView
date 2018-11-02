//
//  ViewController.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var collapsibleView: CollapsibleView!
    private let viewModel: ViewModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollView()
        setupConstraints()
        bind(content: viewModel, with: collapsibleView)
        #if DEBUG
        self.view.backgroundColor = UIColor.random.withAlphaComponent(0.1)
        #endif
    }

    private func createScrollView() {
        collapsibleView = CollapsibleView(forConstraints: false)
        view.addSubview(collapsibleView)
    }

    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = constrain(view: collapsibleView, within: view, insets: .zero)
        constraints.activate()
    }
}


