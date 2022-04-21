//
//  View.swift
//  CryptoViper
//
//  Created by Ali on 9.04.2022.
//

import Foundation
import UIKit

protocol AnyView {

  var presenter: AnyPresenter? {get set}
  func update(with crptos: [Crypto])
  func update (with error: String)
}

class CryptoViewController: UIViewController, AnyView, UITableViewDelegate , UITableViewDataSource  {
  var cryptos: [Crypto] = []

  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    table.isHidden = true
    return table
  }()

  private let messageLabel: UILabel = {
    let label = UILabel()
    label.isHidden = false
    label.text = "Dowloanding..."
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .yellow
    view.addSubview(tableView)
    view.addSubview(messageLabel)
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
    messageLabel.frame = CGRect(x: view.frame.width / 2 - 100  , y: view.frame.height / 2 - 25  , width: 200, height: 50)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cryptos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = cryptos[indexPath.row].currency
    content.secondaryText = cryptos[indexPath.row].price
    cell.contentConfiguration = content
    cell.backgroundColor = .yellow
    return cell
  }

  func update(with crptos: [Crypto]) {
    DispatchQueue.main.async {
      self.cryptos = crptos
      self.messageLabel.isHidden = true
      self.tableView.reloadData()
      self.tableView.isHidden = false
    }
  }
  func update(with error: String) {
    DispatchQueue.main.async {
      self.cryptos = []
      self.tableView.isHidden = true
      self.messageLabel.text = error
      self.messageLabel.isHidden = false
    }
  }
  var presenter: AnyPresenter?
}
