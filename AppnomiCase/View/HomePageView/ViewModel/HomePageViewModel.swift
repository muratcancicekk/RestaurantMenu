//
//  HomePageViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

protocol ViewModelAllCategoriesDelegate : AnyObject {
    func didFinishedGetAllCategories(data: CategoriesModel)
    func didErrorGetAllCategories(error: CustomError)
}

class HomePageViewModel {

    var delegate: ViewModelAllCategoriesDelegate?
    func getallCategories() {
        Network.shared.request(with: .categories) { [weak self] (response: Result<CategoriesModel, CustomError>) in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                self.delegate?.didFinishedGetAllCategories(data: success)
            case .failure(let failure):
                self.delegate?.didErrorGetAllCategories(error: failure)
            }
        }
    }
    
}
