//
//  TableViewCell.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

public protocol TableCellProtocol {
    var txtlabel: UILabel { get }
}

public class TableViewCell: UITableViewCell, TableCellProtocol {
    private var expand = false {
        didSet {
            switcher()
        }
    }

    private var stackView: UIStackView
    private var rightItems:UIStackView
    private var toggleButton: UIButton
    private var btnOne: UIButton
    private var btnTwo: UIButton
    private var btnThree:UIButton

    private var expandableBtns = [UIButton]()

    public private(set) var txtlabel:UILabel

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        /* the look of tableview cell look like

         ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
         ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐ │
         │ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
         │                               │ ┌ ─ ─ ─ ┌ ─ ─ ─ ┌ ─ ─ ─ ┌ ─ ─ ─ │ │
         │ │            label              │  btn  │  btn  │  btn  │  btn  │
         │                               │ └ ─ ─ ─ └ ─ ─ ─ └ ─ ─ ─ └ ─ ─ ─ │ │
         │ │                               │
         │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘ ─ ─ ─ ─ ─ ─ ─ stackview ─ ─ ─ ─ ┤ │
         │
         └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ stackview ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘ │
         │
         ─ ─ ─ ─ ─ ─ ─ ─tableViewcell─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘
         */
        stackView = UIStackView(forConstraints: false)
        txtlabel = UILabel(forConstraints: false)
        rightItems = UIStackView(forConstraints: false)
        toggleButton = UIButton(forConstraints: false)
        btnOne = UIButton(forConstraints: false)
        btnTwo = UIButton(forConstraints: false)
        btnThree = UIButton(forConstraints: false)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupLabel()
        setupRightItems()
        setupExpansion()
        setupEllipses()
        switching(toExpand: false)
        setupConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fill
        contentView.addSubview(stackView)
    }

    private func setupLabel() {
        txtlabel.backgroundColor = UIColor.random
        txtlabel.numberOfLines = 0
        txtlabel.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.addArrangedSubview(txtlabel)
    }

    private func setupRightItems() {
        rightItems.axis = .horizontal
        rightItems.setContentHuggingPriority(.required, for: .horizontal)
        rightItems.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightItems.spacing = 4
        stackView.addArrangedSubview(rightItems)

    }

    private func switcher() {
        switching(toExpand: expand)

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.layoutIfNeeded()
        }

    }

    private func switching(toExpand: Bool) {
        let priority: UILayoutPriority = toExpand ? .required : .defaultLow
        for btn in expandableBtns {
            btn.isHidden = !toExpand
            btn.setContentHuggingPriority(
                priority,
                for: .horizontal
            )
            btn.setContentCompressionResistancePriority(
                priority,
                for: .horizontal
            )
        }
    }


    private func setupEllipses() {
        toggleButton.setTitle("Respond", for: .normal)
        toggleButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        toggleButton.setTitleColor(UIColor.random, for: .normal)
        toggleButton.setContentHuggingPriority(.required, for: .horizontal)
        toggleButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightItems.addArrangedSubview(toggleButton)
    }

    private func setupExpansion() {
        expandableBtns.append(contentsOf: [btnOne, btnTwo, btnThree])
        let btnStyle = ButtonStyle()
        btnOne.setTitle("Accept", for: .normal)
        btnTwo.setTitle("Maybe", for: .normal)
        btnThree.setTitle("Decline", for: .normal)
        expandableBtns.map { btn in
            btn.apply(style: btnStyle)
            rightItems.addArrangedSubview(btn)
        }
    }

    private func setupConstraints() {
        //TODO: constraint to contentView or self?
        let constraints : [NSLayoutConstraint] = constrain(view: stackView, within: self.contentView, insets: .zero)
        constraints.activate()
    }

    @objc private func moreButtonTapped() {
        expand = !expand
    }
}

