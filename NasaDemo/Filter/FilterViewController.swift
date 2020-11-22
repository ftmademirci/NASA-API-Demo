//
//  FilterViewController.swift
//  NasaDemo
//
//  Created by Admin on 17.11.2020.
//

import UIKit

class FilterViewController: UIViewController {
    
    var delegate: FilterDelegate?
    
    @IBOutlet var tableView: UITableView!
    var viewModel: FilterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.filterByCamera(self.viewModel.getRow(indexPath.row).lowercased())
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .gray
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = self.viewModel.getRow(indexPath.row)
        return cell
    }
}
