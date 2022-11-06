//
//  ProductsCollectionViewCell.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import SnapKit

class ProductsCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

    let headerLabel = UILabel()
    let priceLabel = UILabel()
    let discountedPriceLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews(imageView, headerLabel, priceLabel, discountedPriceLabel)
        applyStyle()
        setSnapkit()
    }
    private func applyStyle() {
        imageView.cornerRadius = 8
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleToFill

        headerLabel.styleLabel(title: "", textAlignment: .center, color: .black, fontSize: UIFont.systemFont(ofSize: 18))
        headerLabel.numberOfLines = 0
        priceLabel.styleLabel(title: "", textAlignment: .center, color: .lightGray, fontSize: UIFont.systemFont(ofSize: 16))
        discountedPriceLabel.styleLabel(title: "", textAlignment: .center, color: .black, fontSize: UIFont.systemFont(ofSize: 20))
        self.borderColor = .lightGray
        self.borderWidth = 0.5
        self.cornerRadius = 8
    }
    private func setSnapkit() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 164, height: 164))
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(9)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(discountedPriceLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        discountedPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

    }
    func setCollectionView(product: SingleProductModel) {
        if product.campaignPrice != nil {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: (product.price?.toString ?? "") + "$")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            self.priceLabel.attributedText = attributeString
        }
        else {
            self.priceLabel.text = (product.price?.toString ?? "") + "$"
        }
        self.imageView.setImage(with: product.images?.first?.nyp)
        self.headerLabel.text = product.title ?? ""
        discountedPriceLabel.text = (product.campaignPrice?.toString ?? "") + "$"
        if product.campaignPrice == nil {
            discountedPriceLabel.isHidden = true
            priceLabel.textColor = .black
            self.priceLabel.text = (product.price?.toString ?? "") + "$"
        }
    }

}
