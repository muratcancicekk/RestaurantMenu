//
//  DetailsViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

struct DetailsViewData {
    let id: String
}
enum DetailsViewState {
    case detailsViewDidLoad
}

class DetailsViewModel: BaseViewModel {
    lazy var service = Service()
    var productDetails: ProductDetails?
    var id: String
    init(data: DetailsViewData) {
        self.id = data.id
    }
    override func start() {
        service.getProductDetail(id: id) { [weak self] product in
            if let product = product?.data {
                self?.productDetails = product
                self?.changeState(to: DetailsViewState.detailsViewDidLoad)
            }
        } failure: { [weak self] error in
            self?.handleError(error: error)
        }
    }
}
