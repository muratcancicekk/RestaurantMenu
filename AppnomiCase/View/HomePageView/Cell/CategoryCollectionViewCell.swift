//
//  CategoryCollectionViewCell.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let subLabel = UILabel()
    let rigthIconView = UIImageView()
    let iconView = UIImageView()
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews(titleLabel,rigthIconView,subLabel,iconView)
        applyStyle()
        setSnapkit()
    }
    private func applyStyle(){
        titleLabel.styleLabel(title: "CategoryRandomTitle", textAlignment: .left, color: .black, fontSize: UIFont.systemFont(ofSize: 16))
        subLabel.styleLabel(title: "SubLabel", textAlignment: .left, color: .lightGray, fontSize: UIFont.systemFont(ofSize: 14))
        rigthIconView.image = UIImage(named: "path_icon")
        rigthIconView.contentMode = .center
        iconView.image = UIImage(named: "path_icon")
        self.borderWidth = 0.5
        self.borderColor = .lightGray
        self.cornerRadius = 8
        
    }
    private func setSnapkit(){
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 54, height: 54))

            
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(iconView.snp.right).offset(16)
        
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(iconView.snp.right).offset(16)
        }
        rigthIconView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
           
            make.size.equalTo(CGSize(width: 7, height: 14))

        }
        
    }
    
    func setCollectionView(category:Categories){
        self.subLabel.text = "Toplam Ürün Sayısı: \(category.totalProducts ?? 0)"
        self.iconView.setImage(with: category.icon)
        self.titleLabel.text = category.name
    }

}


