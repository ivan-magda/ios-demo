/**
 * Copyright (c) 2017 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// MARK: ContactsTableViewController: UITableViewController

final class ContactsTableViewController: UITableViewController {

  // MARK: Instance Variables

  private var showIndexPath = false
  private var data = Constants.Contacts.names

  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  // MARK: UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let item = data[section]

    return item.isExpanded ? item.names.count : 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(for: indexPath) as ContactsTableViewCell
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ContactsHeaderViewCell.identifier) as? ContactsHeaderViewCell

    if headerView == nil {
      headerView = ContactsHeaderViewCell { [weak self] (sender) in
        self?.handleExpandClose(at: section, sender: sender)
      }
    }

    return headerView
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return ContactsHeaderViewCell.defaultHeight
  }

  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    configure(cell, atIndexPath: indexPath)
  }

  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let headerView = view as? ContactsHeaderViewCell else {
      return
    }

    configure(headerView, forSection: section)
  }

}

// MARK: - ContactsTableViewController (Configure UI) -

extension ContactsTableViewController {

  private func setup() {
    navigationItem.title = "Contacts"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self,
            action: #selector(onShowIndexPath))
    navigationController?.navigationBar.prefersLargeTitles = true

    tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
  }

  private func configure(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
    let viewModel = ContactsTableViewModel(data: data[indexPath.section])

    cell.textLabel?.text = viewModel.getTitle(for: indexPath.row)
    cell.detailTextLabel?.text = showIndexPath ? "Section: \(indexPath.section) Row: \(indexPath.row)" : nil
  }

  private func configure(_ headerViewCell: ContactsHeaderViewCell, forSection section: Int) {
    let viewModel = ContactsTableViewModel(data: data[section])

    headerViewCell.titleText = "Section: \(section)"
    headerViewCell.actionTitle = viewModel.actionTitle
  }

}

// MARK: - Actions -

extension ContactsTableViewController {

  @objc private func onShowIndexPath() {
    showIndexPath = !showIndexPath

    let sectionsRange = Range(uncheckedBounds: (0, tableView.numberOfSections))
    tableView.reloadSections(IndexSet(integersIn: sectionsRange), with: showIndexPath ? .right : .left)
  }

  private func handleExpandClose(at section: Int, sender: UIButton) {
    let item = data[section]
    let isExpanded = !item.isExpanded

    data[section].isExpanded = isExpanded
    let indexPaths = item.names.indices.map { i in IndexPath(row: i, section: section)  }

    if isExpanded {
      tableView.insertRows(at: indexPaths, with: .fade)
    } else {
      tableView.deleteRows(at: indexPaths, with: .fade)
    }

    let viewModel = ContactsTableViewModel(data: data[section])
    sender.setTitle(viewModel.actionTitle, for: .normal)
  }

}
