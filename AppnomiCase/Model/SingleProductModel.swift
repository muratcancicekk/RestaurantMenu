//
//  SingleProductModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
struct SingleProductModel: Codable {
    let id, appID: String?
    let category: Category?
    let categoryID: String?
    let isUnLimitedStock: Bool?
    let title: String?
    let featuredImage: FeaturedImage?
    let images: [FeaturedImage]?
    let datumDescription: String?
    let stock: Int?
    let stockCode: String?
    let price: Double?
    let currency: String?
    let maxQuantityPerOrder: Int?
    let itemType: String?
    let campaignPrice, shippingPrice: Double?
    let orderIndex : Int?
    let isPublished, isActive: Bool?
    let publishmentDate, endDate, createDate, updateDate: String?
    let useFixPrice: Bool?
    let brand: Brand?
    let brandID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case appID = "appId"
        case category
        case categoryID = "categoryId"
        case isUnLimitedStock, title, featuredImage, images
        case datumDescription = "description"
        case stock, stockCode, price, currency, maxQuantityPerOrder,
             itemType, campaignPrice, shippingPrice, orderIndex, isPublished,
             isActive, publishmentDate, endDate, createDate, updateDate, useFixPrice, brand
        case brandID = "brandId"
    }
}
