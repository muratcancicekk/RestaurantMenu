//
//  Service.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 2.06.2023.
//

import Foundation

class Service {
    // MARK: Home Page Categories
    func getallCategories(success:@escaping ((CategoriesModel?) -> Void),failure: @escaping ((CustomError) -> Void)) {
        Network.shared.request(with: .categories) {  (response: Result<CategoriesModel, CustomError>) in
            switch response {
            case .success(let responce):
                success(responce)
            case .failure(let error):
                failure(error)
            }
        }
    }
    // MARK: ProductCategory
    func getAllProductCategory(requestType: RequestType, success:@escaping ((ProductForAnCategory?) -> Void),failure: @escaping ((CustomError) -> Void)) {
        Network.shared.request(with: requestType) {  (response: Result<ProductForAnCategory, CustomError>) in
            switch response {
            case .success(let responce):
                success(responce)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
