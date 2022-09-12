//
//  AppnomiBaseViewController.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit

class AppnomiBaseViewController: UIViewController {
    let headerLabel = UILabel()
    let logo = UIImageView()
    let child = SpinnerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(headerLabel, logo)

        applyStyle()
        setSnapkit()


    }
    private func applyStyle() {
        headerLabel.styleLabel(title: "Appnomi", textAlignment: .center, color: .black, fontSize: UIFont.systemFont(ofSize: 16))
        logo.image = UIImage(named: "appnomi_logo")

    }
    private func setSnapkit() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.left.equalToSuperview().offset(155)
        }
        logo.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(48)
            make.size.equalTo(CGSize(width: 25, height: 25))

        }

    }
    func makePush(toView: UIViewController)
    {
        self.navigationController?.pushViewController(toView, animated: true)
      
    }
    func makePop() {
        self.navigationController?.popViewController(animated: true)
    }

    func stopAndHideSpinner() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }


}
