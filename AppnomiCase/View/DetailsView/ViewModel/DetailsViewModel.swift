//
//  DetailsViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

protocol ViewModelSingleProductDelegate : AnyObject {
    func didFinishedGetSingleProduct(data: SingleProductDetailModel)
    func didErrorGetSingleProducts(error: CustomError)
}

class DetailsViewModel{
    
    var delegate : ViewModelSingleProductDelegate?

    func getSingleProduct(productId: String) {
        Network.shared.request(with: .productDetail(productId: productId)) { [weak self] (response: Result<SingleProductDetailModel, CustomError>) in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                self.delegate?.didFinishedGetSingleProduct(data: success)
            case .failure(let failure):
                self.delegate?.didErrorGetSingleProducts(error: failure)
            }
        }
    }
}
