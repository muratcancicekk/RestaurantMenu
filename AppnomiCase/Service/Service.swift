//
//  Service.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 2.06.2023.
//

import Foundation

class Service {
    // MARK: Home Page Categories Service
    func getallCategories(success: @escaping ((CategoriesModel?) -> Void),
                          failure: @escaping ((CustomError) -> Void)) {
        Network.shared.request(with: .categories) {  (response: Result<CategoriesModel, CustomError>) in
            switch response {
            case .success(let responce):
                success(responce)
            case .failure(let error):
                failure(error)
            }
        }
    }
    // MARK: ProductCategory Service
    func getAllProductCategory(requestType: RequestType, success: @escaping ((ProductForAnCategory?) -> Void),
                               failure: @escaping ((CustomError) -> Void)) {
        Network.shared.request(with: requestType) {  (response: Result<ProductForAnCategory, CustomError>) in
            switch response {
            case .success(let responce):
                success(responce)
            case .failure(let error):
                failure(error)
            }
        }
    }
    // MARK: ProductDetail Service
    func getProductDetail(id: String,
                          success: @escaping ((ProductDetailModel?) -> Void),
                          failure: @escaping ((CustomError) -> Void) ) {
        Network.shared.request(with: .productDetail(productId: id)) { (response: Result<ProductDetailModel, CustomError>) in
            switch response {
            case .success(let responce):
                success(responce)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
