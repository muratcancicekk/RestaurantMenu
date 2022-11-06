//
//  HomePageViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
import UIKit

protocol ViewModelAllCategoriesDelegate {
    var view: HomePageInterface? {
        get set
    }
    func collectionViewRegister()
    func didFinishedGetAllCategories(data: CategoriesModel)
    func didErrorGetAllCategories(error: CustomError)
    func viewDidLoad()
    func setSnapkit()
    func applyStyle()
    func didSelectItemAt(collectionView: UICollectionView,at indexPath: IndexPath)
}
protocol ViewModelHomePageDelegate {
    func didFinishedGetAllCategories(data: CategoriesModel)
    func didErrorGetAllCategories(error: CustomError)
}

class HomePageViewModel {

    weak var view: HomePageInterface?
    var delegate: ViewModelHomePageDelegate?
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
extension HomePageViewModel: ViewModelAllCategoriesDelegate {
    func didSelectItemAt(collectionView: UICollectionView,at indexPath: IndexPath) {
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as? CategoryCollectionViewCell
        collection?.isSelected.toggle()
        print(indexPath.row)
    }

    func applyStyle() {
        view?.applyStyleConfigure()
    }

    func setSnapkit() {
        view?.snapkitConfigure()
    }

    func viewDidLoad() {
        view?.viewDidLoadConfigure()
    }

    func collectionViewRegister() {
        view?.prepareCollectionView()

    }

    func didFinishedGetAllCategories(data: CategoriesModel) {
        view?.fetchData(data: data)

    }

    func didErrorGetAllCategories(error: CustomError) {
    }
}
