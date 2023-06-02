//
//  HomePageViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
import UIKit

enum HomePageViewState {
    case homeDidLoad
}
class HomePageViewModel: BaseViewModel {

    lazy var homeService = Service()
    var categories = [Categories]()
    override func start() {
        homeService.getallCategories { [weak self] categories in
            guard let categories = categories?.data else {return }
            self?.categories = categories
            self?.changeState(to: HomePageViewState.homeDidLoad)
        } failure: { [weak self] error in
            self?.handleError(error: error)
        }
    }
}
