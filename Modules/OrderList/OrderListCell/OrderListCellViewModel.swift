//
//  OrderListCellViewModel.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import UIKit

protocol OrderListCellViewModelProtocol: AnyObject {
    var orders: FullData { get set }
}

final class OrderListCellViewModel: OrderListCellViewModelProtocol {
    
    var orders: FullData
    
    var startCityAddress: String {
        return orders.startAddress.city
    }
    
    var startAddress: String {
        return orders.startAddress.address
    }
    
    var endCityAddress: String {
        return orders.endAddress.city
    }
    
    var endAddress: String {
        return orders.endAddress.address
    }
    
    var price: String {
        return String("\(orders.price.amount / 100).\(orders.price.amount % 100)\(orders.price.currency)")
    }
    
    var orderTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, EEEE"
        let orderTime = formatter.string(from: orders.orderTime)
        return orderTime
    }
    
    init(order: FullData) {
        orders = order
    }
}
