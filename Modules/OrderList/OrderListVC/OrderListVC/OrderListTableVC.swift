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
        return viewModel.numberOfRowInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: "orderCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderListTableViewCell else {
            fatalError("Some error")
        }
        
        let cellViewModel = viewModel.returnCell(forIndexPath: indexPath)
        cell.viewModel = cellViewModel as? OrderListCellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailVC()
        vc.viewModel = viewModel.returnDetailViewModel(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlertError(withError error: String) {
        let error = error
        let allertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Try again", style: .default))
        present(allertController, animated: true)
    }
    
    private func setupUI() {
        title = "Order list"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: "orderCell")
    }
    
}
