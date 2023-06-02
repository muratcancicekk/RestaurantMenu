//
//  AppnomiBaseViewController.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import UIKit
import Combine
// swiftlint:disable identifier_name
// swiftlint:disable force_cast
class AppnomiBaseViewController<T: BaseViewModel, S>: UIViewController, AlertShowable {
    var viewModel: T!
    var cancellables: Set<AnyCancellable> = []
    let headerLabel = UILabel()
    let logo = UIImageView()
    let child = SpinnerViewController()
    init(viewModel: T) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.didStateChanged = { [weak self] o, n in
            DispatchQueue.main.async { [weak self] in
                self?.didStateChanged(oldState: o as? S, newState: n as! S)
            }
        }
        self.viewModel.errorMessageHandler = { message in
            DispatchQueue.main.async {
                self.showAlert(message: message)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(headerLabel, logo)
        viewModel.start()
        self.bind()
        applyStyle()
        setSnapkit()
    }
    func bind() {}

    func didStateChanged(oldState: S?, newState: S) {}
    
    private func applyStyle() {
        headerLabel.styleLabel(title: "Appnomi",
                               textAlignment: .center,
                               color: .black,
                               fontSize: UIFont.systemFont(ofSize: 16))
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
