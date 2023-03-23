//
//  OrderListTableVC.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import UIKit


final class OrderListTableVC: UITableViewController {
    
    private var viewModel: ViewControllerViewModelProtocol! {
        didSet {
            viewModel.getOrders { [weak self] error in
                self?.showAlertError(withError: error)
            } successComplition: {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = ViewControllerViewModel()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nubmerOfRowInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(OrderListTableViewCell.cell, forCellReuseIdentifier: "orderCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderListTableViewCell) else {
            fatalError("Some error")
        }
        
        let cellViewNodel = viewModel.returnCell(forindexPath: indexPath)
        cell.viewModel = cellViewModel as? OrderListCellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.viewModel = viewModel.returnDetailViewModel(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlertError(withError: error) {
        // дописать алерт
    }
    
    private func setupUI() {
        title = "Order list"
        UINavigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: "orderCell")
    }
    
}
