//
//  ConsentViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import UIKit
import WebKit

class ConsentViewController: BaseViewController {
    
    // MARK: Storyboard UI Component
    @IBOutlet weak var checkAcceptBoxView: UIView!
    @IBOutlet weak var checkAcceptTitleLabel: UILabel!
    @IBOutlet weak var checkAcceptImageView: UIImageView!
    @IBOutlet weak var checkAcceptButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Variable
    var viewModel: ConsentViewModel!
    var router: ConsentRouter!

    // MARK: Life cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        router = ConsentRouter(self)
        
        setupUI()
        bindViewModel()
        viewModel.getConsent()
    }
    
    // MARK: Storyboard UI Action
    @IBAction func onTouchAcceptButton() {
        setAcceptConsent(isAccept: true)
    }
    
    @IBAction func onTouchDelineButton() {
        setAcceptConsent(isAccept: false)
    }
    
    @IBAction func onTouchAcceptCheckBoxButton() {
        viewModel.isAccept.toggle()
        setCheckAcceptButtonState(isEnable: viewModel.isAccept)
    }
    
    // MARK: Binding View with ViewModel
    private func bindViewModel() {
        viewModel.$displayConsent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] consent in
                guard let self = self else {return}
                self.configureNavigationBar(title: consent?.getTitle(context: self) ?? "")
                
                if let url = URL(string: consent?.consentLink ?? "") {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                }
            }
            .store(in: &cancellables)

        viewModel.$isAccept
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAccept in
                self?.checkAcceptImageView.isHidden = !isAccept
            }
            .store(in: &cancellables)
    }
    
    // MARK: Method
    private func setupUI() {
        webView.scrollView.delegate = self
        setCheckAcceptBoxState(isEnable: false)
        setCheckAcceptButtonState(isEnable: viewModel.isAccept)
    }
    
    private func setCheckAcceptBoxState(isEnable: Bool) {
        checkAcceptBoxView.backgroundColor = isEnable ? UIColor(colorName: .white) : UIColor(colorName: .gray)
        checkAcceptButton.isEnabled = isEnable
    }
    
    private func setCheckAcceptButtonState(isEnable: Bool) {
        acceptButton.isEnabled = isEnable
        acceptButton.backgroundColor = isEnable ? UIColor(colorName: .primary) : UIColor(colorName: .gray)
    }
    
    private func setAcceptConsent(isAccept: Bool) {
        viewModel.acceptConsent(isAccept)
        if let nextIndex = viewModel.getNextConsentIndex() {
            router.toConsentPage(consentList: viewModel.consentList,
                                    selectedIndex: nextIndex)
        } else {
            router.toRegisterPage(consentList: viewModel.consentList)
        }
    }
}

extension ConsentViewController: WKNavigationDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let scrollViewHeight = scrollView.frame.size.height
            let scrollContentSizeHeight = scrollView.contentSize.height
            let scrollOffset = scrollView.contentOffset.y

            // Check Scroll to Bottom
            if scrollOffset + scrollViewHeight >= scrollContentSizeHeight {
                setCheckAcceptBoxState(isEnable: true)
            }
        }
}
