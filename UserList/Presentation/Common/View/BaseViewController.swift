//
//  BaseViewController.swift
//  UserList
//
//  Created by Mher Davtyan on 31.07.22.
//

import UIKit
import Toast_Swift

enum ViewState {
    case loading
    case populated
    case empty
    case error(Error?)
}

class BaseViewController: UIViewController, LoadingControl {
    
    var overlay: UIView?
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToastManager()
    }
    
    var state: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setupState()
            }
        }
    }
    
    func setErrorView(_ error: Error?) { }
    
    func setLoadingView() { }

    func setEmptyView() { }

    func setPopulatedView() { }

    func setupState() {
        switch state {
        case .error(let error):
            setErrorView(error)
        case .loading:
            setLoadingView()
        case .empty:
            setEmptyView()
        case .populated:
            setPopulatedView()
        }
    }
    
    private func setupToastManager() {
        var style = ToastStyle()
        style.backgroundColor = .systemPink
        style.messageFont = UIFont.boldSystemFont(ofSize: 16.0)
        style.messageAlignment = .center
        style.messageColor = .white
        style.displayShadow = true
        style.shadowColor = .systemPink
        style.shadowRadius = 8
        style.shadowOffset = CGSize(width: 0, height: 4)
        style.shadowOpacity = 0.3
        style.maxWidthPercentage = (UIScreen.main.bounds.width - 40) / UIScreen.main.bounds.width
        
        ToastManager.shared.duration = 1.5
        ToastManager.shared.isQueueEnabled = true
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.style = style
    }
    
    func showErrorMessage(_ error: Error?) {
        if let errorInfo = error?.localizedDescription {
            view.window?.makeToast(errorInfo)
        }
    }
    
    func showErrorMessage(_ error: String?) {
        if let errorInfo = error {
            view.window?.makeToast(errorInfo)
        }
    }
}
