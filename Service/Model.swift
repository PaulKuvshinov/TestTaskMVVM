//
//  Model.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import Foundation

struct MainData: Codable {
    let id: Int
    let startAddress: Address
    let endAddress: Address
    let price: Price
    let orderTime: Date
    let car: Car
}

struct Address: Codable {
    let city: String
    let address: String
}

struct Price: Codable {
    let amount: Int
    let currency: String
}

struct Car: Codable {
    let autoNumber: Int
    let autoModel: String
    let autoPhoto: String
    let driver: String
}

typealias FullData = [MainData]
