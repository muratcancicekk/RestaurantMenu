//
//  HomePageViewController.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import SnapKit


protocol HomePageInterface: AnyObject {
    func fetchData(data: CategoriesModel)
    func prepareCollectionView()
    func viewDidLoadConfigure()
    func snapkitConfigure()
    func applyStyleConfigure()
}

class HomePageViewController: AppnomiBaseViewController {

    let layoutVertical: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let layoutHorizantal: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let categoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var categories = [Categories]()

    private lazy var viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.delegate = self
        viewModel.viewDidLoad()
       

    }

     func collectionViewRegister() {
         viewModel.collectionViewRegister()
    }
    private func applyStyle() {
        viewModel.applyStyle()
    }
    
    private func setSnapkit() {
        viewModel.setSnapkit()
    }

}
extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]

        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as! CategoryCollectionViewCell
        collection.setCollectionView(category: category)
        return collection

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.width * 0.9, height: 72)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(collectionView: collectionView, at: indexPath)
        let choisenCategory = categories[indexPath.row]
        makePush(toView: ProductsListViewController(categoryID: choisenCategory.categoryID ?? ""))
      
    }


}

extension HomePageViewController: ViewModelHomePageDelegate{
    func didFinishedGetAllCategories(data: CategoriesModel) {
        viewModel.didFinishedGetAllCategories(data: data)
        
    }
    
    func didErrorGetAllCategories(error: CustomError) {
        print(error)
    }
    
    
}

extension HomePageViewController:HomePageInterface {
   
    
    func applyStyleConfigure() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func snapkitConfigure() {
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    func viewDidLoadConfigure() {
        view.addSubviews(categoryCollectionView)
        viewModel.getallCategories()
        collectionViewRegister()
        applyStyle()
        setSnapkit()
    }
    
    
    func prepareCollectionView() {
        layoutVertical.scrollDirection = UICollectionView.ScrollDirection.vertical
        layoutHorizantal.scrollDirection = UICollectionView.ScrollDirection.horizontal
        categoryCollectionView.setCollectionViewLayout(layoutVertical, animated: true)
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
   
    func fetchData(data: CategoriesModel) {
        guard let data = data.data else {
            return
        }
        categories = data
        if !categories.isEmpty {
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
                self.stopAndHideSpinner()

            }
        }
    }
    
    
  
}

