//
//  BaseViewModel.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 29.05.2023.
//

import Foundation
import Combine

class BaseViewModel {

    var cancellables: Set<AnyCancellable> = []
    private var state: Any?
    var didStateChanged: ((_ oldState: Any?, _ newState: Any) -> Void)?
    var errorMessageHandler: ((String) -> Void)?

    func start() {}

    func changeState(to state: Any) {
        didStateChanged?(self.state, state)
        self.state = self
    }

    func handleError(error: CustomError? = nil, message: String? = nil) {
        if let message = message {
            errorMessageHandler?(message)
        } else if let error = error {
            errorMessageHandler?(message ?? "")
        }
    }
}
