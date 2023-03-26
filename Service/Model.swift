//
//  Model.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import Foundation

struct FullData: Codable {
    let id: Int
    let startAddress: Address
    let endAddress: Address
    let price: Price
    let orderTime: Date
    let vehicle: Vehicle
}

struct Address: Codable {
    let city: String
    let address: String
}

struct Price: Codable {
    let amount: Int
    let currency: String
}

struct Vehicle: Codable {
    let regNumber: String
    let modelName: String
    let photo: String
    let driverName: String
}

typealias MainData = [FullData]
