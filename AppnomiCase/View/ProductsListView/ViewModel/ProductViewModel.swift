//
//  ProductViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
protocol ViewModelGetProductDelegate : AnyObject {
    func didFinishedGetProductForAnCategory(data: ProductForAnCategory)
    func didErrorGetProductForAnCategory(error: CustomError)
}

class ProductListViewModel {
    var delegate : ViewModelGetProductDelegate?

    func getProductForAnCategory(with resquestType: RequestType) {
        Network.shared.request(with: resquestType) { [weak self] (response: Result<ProductForAnCategory, CustomError>) in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                self.delegate?.didFinishedGetProductForAnCategory(data: success)
            case .failure(let failure):
                self.delegate?.didErrorGetProductForAnCategory(error: failure)
            }
        }
    }
}
