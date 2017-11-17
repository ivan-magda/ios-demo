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

  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  // MARK: UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return Constants.Contacts.names.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.Contacts.names[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ContactsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    configure(cell, atIndexPath: indexPath)

    return cell
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Section: \(section)"
  }

  // MARK: Actions

  @objc private func onShowIndexPath() {
    showIndexPath = !showIndexPath

    let sectionsRange = Range(uncheckedBounds: (0, tableView.numberOfSections))
    tableView.reloadSections(IndexSet(integersIn: sectionsRange), with: showIndexPath ? .right : .left)
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
    let name = Constants.Contacts.names[indexPath.section][indexPath.row]

    cell.textLabel?.text = name

    if showIndexPath {
      cell.detailTextLabel?.text = "Section: \(indexPath.section) Row: \(indexPath.row)"
    }
  }

}
