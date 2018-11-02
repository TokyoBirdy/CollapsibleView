//
//  TableViewDataSource.swift
//  CollapsibleView
//
//  Created by ceciliah on 10/26/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    private let randomRange = 40...100
    private let dummyRowNumbers = 20

    let cellIdentifier = "Cell"

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let destinationCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell {
            destinationCell.txtlabel.text = String.random(length:Int.random(in: randomRange))

            destinationCell.txtlabel.setContentCompressionResistancePriority(.required, for: .vertical)
            destinationCell.txtlabel.setContentHuggingPriority(.required, for: .vertical)

            destinationCell.selectionStyle = .none
            return destinationCell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyRowNumbers
    }
}

