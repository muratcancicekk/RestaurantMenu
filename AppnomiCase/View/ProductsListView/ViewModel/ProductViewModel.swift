//
//  ProductViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
import UIKit


enum ProductListViewState {
    case productListDidLoad
}
class ProductListViewModel: BaseViewModel {
    lazy var service = Service()
    var products = [ProductDetails]()
    var categoryID: String
    init(categoryID: String) {
        self.categoryID = categoryID
    }
    override func start() {
        getProductCategory(requestType: .productForAnCategorySortTitle(categoryId: categoryID))
    }
    func getProductCategory(requestType: RequestType) {
        service.getAllProductCategory(requestType: requestType) { [weak self] product in
            if let product = product?.data {
                self?.products = product
                self?.changeState(to: ProductListViewState.productListDidLoad)
            }
        } failure: { [weak self] error in
            self?.handleError(error: error)
        }

    }
    func getProducts(data: ProductForAnCategory, selected: String) {
        guard let data = data.data else {
            return
        }
        self.products = data
        if selected == "Alfabetik A-Z" {
            var products = [ProductDetails]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
            
        } else if selected == "Fiyat Artan" {
            var products = [ProductDetails]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
        } else if selected == "Eskiden Yeniye" {
            var products = [ProductDetails]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
        }
    }
}
