//
//  CollapsibleView.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class CollapsibleView:UIView {

    var tableView: UITableView
    var headerView: UIView
    var headerImageView: UIImageView
    var tableViewDataSource: TableViewDataSource

    override init(frame: CGRect) {
        tableView = UITableView(frame: .zero, style: .plain)
        headerView = UIView(forConstraints: false)
        headerImageView = UIImageView(forConstraints: false)

        tableViewDataSource = TableViewDataSource()

        super.init(frame: frame)
        setupImageView()
        setupHeaderView()
        setupTableView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        self.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableHeaderView = headerView

        tableView.dataSource = tableViewDataSource
        tableView.backgroundColor = UIColor.clear
    }

    private func setupHeaderView() {
        headerView.accessibilityIdentifier = "headerView"
        #if DEBUG
        headerView.backgroundColor = UIColor.yellow.withAlphaComponent(0.1)
        let width = UIScreen.main.bounds.width
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: width))
        #endif
    }

    private func setupImageView() {
        headerImageView.clipsToBounds = false
        headerImageView.contentMode = .scaleAspectFill
        headerView.addSubview(headerImageView)
    }

    private func setupConstraints() {

        var constraints: [NSLayoutConstraint] = constrain(view: tableView, within: self, insets: .zero)
        let headerViewConstraints: [NSLayoutConstraint] = [
            headerView.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: tableView.widthAnchor),
            headerView.topAnchor.constraint(equalTo: tableView.topAnchor)
        ]

        constraints.append(contentsOf:headerViewConstraints)

        let imgConstraints: [NSLayoutConstraint] = constrain(view: headerImageView, within: headerView, insets: .zero)
        constraints.append(contentsOf: imgConstraints)
        constraints.activate()
    }
}
