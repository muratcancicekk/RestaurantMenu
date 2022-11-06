//
//  DetailsViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

protocol DetailsViewModelDelegate {
    var view: DetailsViewInterface? { get set }
    func viewDidLoad()
    func scroll()
    func applyStyle()
    func setSnapkit()
}

protocol ViewModelSingleProductFetch {
    func didFinishedGetSingleProduct(data: SingleProductDetailModel)
    func didErrorGetSingleProducts(error: CustomError)
}

class DetailsViewModel {
    weak var view:DetailsViewInterface?
    var delegate: ViewModelSingleProductFetch?

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

extension DetailsViewModel:DetailsViewModelDelegate{
    func setSnapkit() {
        view?.snapkitConfigure()
    }
    
    func applyStyle() {
        view?.styleConfigure()
    }
    
    func scroll() {
        view?.scrollConfigure()
    }
    
    func viewDidLoad() {
        view?.viewDidLoadConfigure()
    }
    
    
}
