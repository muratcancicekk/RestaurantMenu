import UIKit
import SnapKit

class ProductsListViewController: AppnomiBaseViewController<ProductListViewModel, ProductListViewState> {
    private let layoutVertical: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let layoutHorizantal: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                                          collectionViewLayout: UICollectionViewFlowLayout.init())
    private var picker: UIPickerView = UIPickerView()
    private let filterValues = ["Alfabetik A-Z", "Alfabetik Z-A",
                                "Fiyat Artan",
                                "Fiyat Azalan",
                                "Yeniden Eskiye",
                                "Eskiden Yeniye"]
    var filterButton = UIButton()
    var toolBar = UIToolbar()
    var selected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidloadConfigure()
    }
    override func didStateChanged(oldState: ProductListViewState?, newState: ProductListViewState) {
        super.didStateChanged(oldState: oldState, newState: newState)
        switch newState {
        case .productListDidLoad:
            self.stopAndHideSpinner()
            collectionView.reloadData()
        }
    }
}
extension ProductsListViewController: ConfigureCollectionView, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as? ProductsCollectionViewCell
        let product = viewModel.products[indexPath.row]
        collection?.setCollectionView(product: product)
        return collection!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.width * 0.4, height: UIScreen.height * 0.43)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let choisenProduct = viewModel.products[indexPath.row]
        guard let productID = choisenProduct.id else {
            return
        }
        let detailsViewData = DetailsViewData(id: productID)
        makePush(toView: DetailsViewController(viewModel: DetailsViewModel(data: detailsViewData)))
    }
    
}
extension ProductsListViewController {
    private func setSnapkit() {
        self.filterButton.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    private func styleConfigure() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        self.filterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.filterButton.setImage(UIImage(named: "filter_icon"), for: .normal)
    }
    @objc private func onDoneButtonTappeds() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    @objc private func buttonTapped() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300,
                                   width: UIScreen.main.bounds.size.width,
                                   height: 300)
        self.view.addSubview(picker)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300,
                                                    width: UIScreen.main.bounds.size.width,
                                                    height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done,
                                              target: self,
                                              action: #selector(onDoneButtonTappeds))]
        self.view.addSubview(toolBar)
    }
    private func collectionViewConfigure() {
        layoutVertical.scrollDirection = UICollectionView.ScrollDirection.vertical
        layoutHorizantal.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionView.setCollectionViewLayout(layoutVertical, animated: true)
        collectionView.register(UINib(nibName: "ProductsCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "ProductsCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
    }
    fileprivate func viewDidloadConfigure() {
        view.addSubviews(collectionView, filterButton)
        collectionViewConfigure()
        styleConfigure()
        setSnapkit()
    }
}
extension ProductsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            viewModel.getProductCategory(requestType: .productForAnCategorySortTitle(categoryId: viewModel.categoryID))
        } else if selected == "Fiyat Artan" || selected == "Fiyat Azalan" {
            viewModel.getProductCategory(requestType: .productForAnCategorySortPrice(categoryId: viewModel.categoryID))
        } else if selected == "Yeniden Eskiye" || selected == "Eskiden Yeniye" {
            viewModel.getProductCategory(requestType: .productForAnCategorySortPublishmentDate(categoryId: viewModel.categoryID))
        }
        else {
            viewModel.getProductCategory(requestType: .productForAnCategorySortTitle(categoryId: viewModel.categoryID))
        }
        
    }
}
