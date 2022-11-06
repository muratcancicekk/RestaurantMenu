//
//  ProductViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
import UIKit
protocol ViewModelGetProductDelegate: AnyObject {
    var view: ProductsListInterface? { get set }
    func didFinishedGetProductForAnCategory(data: ProductForAnCategory)
    func didErrorGetProductForAnCategory(error: CustomError)
    func viewDidload()
    func collectionViewRegister()
    func tappedbtn()
    func onDoneButtonTapped()
    func applyStyle()
    func setSnapkit()
}
protocol ViewModelGetProductFetchDelegate {
    func didFinishedGetProductForAnCategory(data: ProductForAnCategory)
    func didErrorGetProductForAnCategory(error: CustomError)
}

class ProductListViewModel {
    var delegate: ViewModelGetProductFetchDelegate?
    var view: ProductsListInterface?

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

extension ProductListViewModel: ViewModelGetProductDelegate {
    func setSnapkit() {
        view?.snapkitConfigure()
    }
    func applyStyle() {
        view?.styleConfigure()
    }
    func onDoneButtonTapped() {
        view?.onDoneButtonTappeds()
    }
    func tappedbtn() {
        view?.buttonTapped()
    }
    func collectionViewRegister() {
        view?.collectionViewConfigure()
    }
    func didFinishedGetProductForAnCategory(data: ProductForAnCategory) {
        view?.getProducts(data: data)
    }

    func didErrorGetProductForAnCategory(error: CustomError) {
        print(error)
    }

    func viewDidload() {
        view?.viewDidloadConfigure()

    }
}
