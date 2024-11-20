//
//  RegisterByEmailViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import UIKit

class RegisterByEmailViewController: BaseViewController {
    
    // MARK: Storyboard UI Component
    @IBOutlet weak var emailView: CustomTextField!
    @IBOutlet weak var submitButton: UIButton!

    // MARK: Variable
    var viewModel: RegisterByEmailViewModel!
    var router: RegisterByEmailRouter!
    
    // MARK: Life cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        router = RegisterByEmailRouter(self)
        viewModel = RegisterByEmailViewModel()
        bindViewModel()
        setupUI()
    }

    // MARK: Storyboard UI Action
    @IBAction func onTouchSubmitButton() {
        viewModel.email = emailView.textField.text ?? ""
        if viewModel.validate() {
            viewModel.callVerifyEmail { [weak self] result in
                if result == .canRegister {
                    self?.callOTP()
                }
            }
        }
    }
    
    
    
    // MARK: Binding View with ViewModel
    private func bindViewModel() {
        viewModel.$emailErrorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.emailView.setErrorMessage(text: errorMessage)
            }
            .store(in: &cancellables)
        
        //call request OTP
        viewModel.$otpResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] otpResponse in
                guard self != nil else {return}
                if let response = otpResponse {
                    self?.router.toVerifyOTP(email: self?.emailView.textField.text ?? "",otpResponse: response)
                }
            }
            .store(in: &cancellables)
        
    }
    
    // MARK: Method
    private func setupUI() {
        configureNavigationBar(title: "Sing Up")
        emailView.setTitleText("Email")
        emailView.setPlaceholderText("Email Address")
        emailView.textField.text = "tanawat.art+20@2c2p.com"
        emailView.setErrorMessage(text: "Please input")
    }
    
    private func callOTP() {
        let req = OTPRequest(email: self.emailView.textField.text ?? "", languageCode:"EN")
        viewModel.doGetOTP(req:req)
    }
        
}
    
