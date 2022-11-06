//
//  Categories.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

struct Categories: Codable {
    let categoryID, name: String?
    let icon: String?
    let orderIndex: Int?
    let createDate, updateDate: String?
    let totalProducts: Int?
    let isActive: Bool?
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, orderIndex, createDate, updateDate, totalProducts, isActive
    }
}
