//
//  ProductForAnCategory.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
struct ProductForAnCategory: Codable {
    let success: Bool?
    let data: [SingleProductModel]?
    let meta: Meta?
}
