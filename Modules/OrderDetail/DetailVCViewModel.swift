//
//  DetailVCViewModel.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import UIKit

protocol DetailVCViewModelProtocol: AnyObject {
    var order: MainData? { get }
    var id: String { get }
    var imageManager: ImageManagerProtocol { get set }
}

final class DetailVCViewModel: DetailVCViewModelProtocol {
    var order: MainData?
    var id: String
    var imageManager: ImageManagerProtocol = ImageManager()
    
    init(order: MainData) {
        self.order = order
        id = String(describing: order.car.autoPhoto)
    }
}
