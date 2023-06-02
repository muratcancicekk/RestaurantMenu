//
//  HomePageViewController.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import SnapKit

class HomePageViewController: AppnomiBaseViewController<HomePageViewModel, HomePageViewState> {

    let layoutVertical: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let layoutHorizantal: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let categoryCollectionView = UICollectionView(frame: CGRect.zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout.init())
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadConfigure()
    }
    override func didStateChanged(oldState: HomePageViewState?, newState: HomePageViewState) {
         super.didStateChanged(oldState: oldState, newState: newState)
        switch newState {
        case .homeDidLoad:
            self.stopAndHideSpinner()
            categoryCollectionView.reloadData()
        }
    }
}
extension HomePageViewController: ConfigureCollectionView, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = viewModel.categories[indexPath.row]
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as? CategoryCollectionViewCell
        collection?.setCollectionView(category: category)
        return collection!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width * 0.9, height: 72)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let choisenCategory = viewModel.categories[indexPath.row]
        if let categoryID = choisenCategory.categoryID {
            makePush(toView: ProductsListViewController(viewModel: ProductListViewModel(categoryID: categoryID)))
        }
    }
}

extension HomePageViewController {
   fileprivate func applyStyleConfigure() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
   private func snapkitConfigure() {
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    private func viewDidLoadConfigure() {
        view.addSubviews(categoryCollectionView)
        prepareCollectionView()
        applyStyleConfigure()
        snapkitConfigure()
    }

    private func prepareCollectionView() {
        layoutVertical.scrollDirection = UICollectionView.ScrollDirection.vertical
        layoutHorizantal.scrollDirection = UICollectionView.ScrollDirection.horizontal
        categoryCollectionView.setCollectionViewLayout(layoutVertical, animated: true)
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: "HomeCategoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
}
