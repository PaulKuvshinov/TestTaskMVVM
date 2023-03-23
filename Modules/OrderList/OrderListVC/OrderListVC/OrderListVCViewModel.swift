//
//  OrderListVCViewModel.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import UIKit

protocol ViewControllerViewModelProtocol: AnyObject {
    var numberOfRowInSection: Int { get }
    func returnCell(forIndexPath indexPath: IndexPath) -> OrderListCellViewModelProtocol?
    func getOrders(complition: @escaping (String) -> Void, successComplition: @escaping() -> Void)
    func returnDetailViewModel(indexPath: IndexPath) -> DetailViewControllerViewModelProtocol?
}

final class ViewControllerViewModel: ViewControllerViewModelProtocol {
    var numberOfRowInSection: Int {
        orders?.count ?? 0
    }
    
    var networkManager: NetworkManagerProtocol? = NetworkManager()
    
    var orders: FullData?
    
    func getOrders(complition: @escaping (String) -> Void, successComplition: @escaping () -> Void) {
        networkManager?.getList {[weak self] result in
            switch result {
            case .success(var fetchedOrders):
                fetchedOrders.sort {
                    $0.orderTime > $1.orderTime
                }
                self?.orders = fetchedOrders
                successComplition()
            case .failure(let error):
                complition(error.localizedDescription)
            }
        }
    }
    
    func returnCell(forIndexPath indexPath: IndexPath) -> OrderListCellViewModelProtocol? {
        
        guard var data = orders else { return nil }
        data.sort {
            $0.orderTime > $1.orderTime
        }
        let order = data[indexPath.row]
        return OrderListCellViewModel(order: order)
    }
    
    func returnDetailViewModel(indexPath: IndexPath) -> DetailVCViewModelProtocol? {
        
        guard let order = orders else { return nil }
        return DetailVCVIewModel(order: order[indexPath.row])
    }
}
