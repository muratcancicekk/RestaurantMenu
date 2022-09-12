//
//  ProductsListViewController.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import SnapKit

class ProductsListViewController: AppnomiBaseViewController {
    private let layoutVertical: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let layoutHorizantal: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let productsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private var picker: UIPickerView = UIPickerView()
    private let categoryID: String
    private let viewModel = ProductListViewModel()
    private var products = [SingleProductModel]()
    private let filterValues = ["Alfabetik A-Z","Alfabetik Z-A","Fiyat Artan","Fiyat Azalan","Yeniden Eskiye","Eskiden Yeniye"]
    var denemeBtn = UIButton()
    var toolBar = UIToolbar()
    var selected = ""

    init(categoryID: String) {
        self.categoryID = categoryID
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.addSubviews(productsCollectionView,denemeBtn)
        collectionViewRegister()
        setSnapkit()
        applyStyle()
        viewModel.getProductForAnCategory(with: .productForAnCategorySortTitle(categoryId: categoryID))
        
     
       

    }
    
    private func collectionViewRegister(){
        layoutVertical.scrollDirection = UICollectionView.ScrollDirection.vertical
        layoutHorizantal.scrollDirection = UICollectionView.ScrollDirection.horizontal
        productsCollectionView.setCollectionViewLayout(layoutVertical, animated: true)
        productsCollectionView.register(UINib(nibName: "ProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCell")
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self

        productsCollectionView.showsVerticalScrollIndicator = false
    }
    @objc func tappedbtn(){
           picker = UIPickerView.init()
           picker.delegate = self
           picker.dataSource = self
           picker.backgroundColor = UIColor.white
           picker.setValue(UIColor.black, forKey: "textColor")
           picker.autoresizingMask = .flexibleWidth
           picker.contentMode = .center
           picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(picker)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .black
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    private func applyStyle() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        self.denemeBtn.addTarget(self, action: #selector(tappedbtn), for: .touchUpInside)
        self.denemeBtn.setImage(UIImage(named:"filter_icon"), for: .normal)
    }
    private func setSnapkit() {
        self.denemeBtn.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(denemeBtn.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(0)

        }
    }




}
extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return products.count


    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCollectionViewCell
        let product = products[indexPath.row]
        collection.setCollectionView(product: product)
        
        return collection

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.width * 0.4, height: UIScreen.height*0.43)


    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let choisenProduct = products[indexPath.row]
        guard let productID = choisenProduct.id else {
            return
        }
        makePush(toView: DetailsViewController(productID: productID))
    }

}

extension ProductsListViewController:ViewModelGetProductDelegate{
    func didFinishedGetProductForAnCategory(data: ProductForAnCategory) {

        guard let data = data.data else {
            return
        }
        self.products = data
        if selected == "Alfabetik A-Z" {
            var products = [SingleProductModel]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
            
        }else if selected == "Fiyat Artan"{
            var products = [SingleProductModel]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
        }else if selected == "Eskiden Yeniye"{
            var products = [SingleProductModel]()
            self.products.reversed().forEach {
                products.append($0)
            }
            self.products = products
        }
                    
        if !products.isEmpty{
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
                self.stopAndHideSpinner()
            }
        }
        
    }
    
    func didErrorGetProductForAnCategory(error: CustomError) {
        print(error)
        
    }
    
    
    
}

extension ProductsListViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = filterValues[row]
        return row
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selected = filterValues[row]
        if selected == "Alfabetik A-Z" || selected == "Alfabetik Z-A"
        {
            viewModel.getProductForAnCategory(with: .productForAnCategorySortTitle(categoryId: categoryID))
        } else if selected ==  "Fiyat Artan" || selected == "Fiyat Azalan" {
            viewModel.getProductForAnCategory(with: .productForAnCategorySortPrice(categoryId: categoryID))
        } else if selected == "Yeniden Eskiye" || selected == "Eskiden Yeniye" {
            viewModel.getProductForAnCategory(with: .productForAnCategorySortPublishmentDate(categoryId: categoryID))
        }
        else {
            viewModel.getProductForAnCategory(with: .productForAnCategorySortTitle(categoryId: categoryID))
        }
        
    }
}
