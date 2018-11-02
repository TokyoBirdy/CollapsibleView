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
    private var expandButton: UIButton
    private var btnOne: UIButton
    private var btnTwo: UIButton
    private var btnThree:UIButton

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
        expandButton = UIButton(forConstraints: false)
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
        btnOne.isHidden = !toExpand
        btnTwo.isHidden = !toExpand
        btnThree.isHidden = !toExpand

        let priority: UILayoutPriority = toExpand ? .required : .defaultLow

        btnOne.setContentHuggingPriority(priority, for: .horizontal)
        btnOne.setContentCompressionResistancePriority(priority, for: .horizontal)
        btnTwo.setContentHuggingPriority(priority, for: .horizontal)
        btnTwo.setContentCompressionResistancePriority(priority, for: .horizontal)
        btnThree.setContentHuggingPriority(priority, for: .horizontal)
        btnThree.setContentCompressionResistancePriority(priority, for: .horizontal)
    }


    private func setupEllipses() {
        expandButton.setTitle("Respond", for: .normal)
        expandButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        expandButton.setTitleColor(UIColor.random, for: .normal)
        expandButton.setContentHuggingPriority(.required, for: .horizontal)
        expandButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        rightItems.addArrangedSubview(expandButton)
    }

    private func setupExpansion() {
        let btnStyle = ButtonStyle()
        btnOne.setTitle("Accept", for: .normal)
        btnTwo.setTitle("Maybe", for: .normal)
        btnThree.setTitle("Decline", for: .normal)
        btnOne.apply(style: btnStyle)
        btnTwo.apply(style: btnStyle)
        btnThree.apply(style: btnStyle)
        rightItems.addArrangedSubview(btnOne)
        rightItems.addArrangedSubview(btnTwo)
        rightItems.addArrangedSubview(btnThree)
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

