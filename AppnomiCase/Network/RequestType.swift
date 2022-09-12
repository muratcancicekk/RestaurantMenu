//
//  RequestType.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
enum RequestType {

    case categories
    case productForAnCategorySortTitle(categoryId: String)
    case productForAnCategorySortPrice(categoryId: String)
    case productForAnCategorySortPublishmentDate(categoryId: String)
    case productDetail(productId: String)



    var endPoint: String {

        switch self {
        case .categories:
            return "/categories"
        case .productForAnCategorySortTitle(categoryId: let categoryId):
            return "/products/advanced-filtered?categoryId=\(categoryId)&sort=Title"
        case .productForAnCategorySortPrice(categoryId: let categoryId):
            return "/products/advanced-filtered?categoryId=\(categoryId)&sort=Price"
        case .productForAnCategorySortPublishmentDate(categoryId: let categoryId):
            return "/products/advanced-filtered?categoryId=\(categoryId)&sort=PublishmentDate"
        case .productDetail(productId: let productId):
            return "/products/" + productId
        }

       
    }
    var httpMethod: HttpMethod {

        switch self {
     
        case .categories:
            return .GET
        case .productForAnCategorySortTitle(categoryId: _):
            return .GET
        case .productForAnCategorySortPrice(categoryId:  _):
            return .GET
        case .productForAnCategorySortPublishmentDate(categoryId: _):
            return .GET
        case .productDetail(productId: _):
            return .GET
    
        }
    }
}
