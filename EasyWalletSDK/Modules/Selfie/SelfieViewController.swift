//
//  RegisterByEmailViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import UIKit
import hummer

class SelfieViewController: BaseViewController {
    
    var router: SelfieRouter!
    var viewModel: SelfieModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar(title: "Verify Identity")
        router = SelfieRouter(self)
        viewModel = SelfieModel()
        bindViewModel()
      
    }
        
    @IBAction func onTouchAcceptButton(_ sender: Any) {
        let metainfo = ZLZFacade.getMetaInfo()
        let encryptedEmail = AES256Manager.encrypt(SessionHelper.shared.email ?? "")
        let req = ZolozInitialFaceRequest(metaInfo: metainfo, userId: encryptedEmail)
        viewModel.initialFaceZoloz(req: req)
 
    }
    private func bindViewModel() {
        // Initial result face
        viewModel.$zolozInitialFaceResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] zolozInitialFaceCapture in
                guard self != nil else {return}
                if let response = zolozInitialFaceCapture {
                    switch response.responseCode {
                    case "000":
                        self?.callZolozCofig(zolozFaceCaptureResponse: response)
                        break;
                    default:
                        AlertHelpers.showError(detail: response.responseCodeAndDesc)
                    }
                }
            }
            .store(in: &cancellables)
        // Check result face
        viewModel.$zolozCheckResultFaceResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] zolozCheckResultFaceCapture in
                guard self != nil else {return}
                if let response = zolozCheckResultFaceCapture {
                    switch response.responseCode {
                    case "000":
                        SessionHelper.shared.zolozfaceInfo = response.faceInfo
                        self?.router.toPersonalInformationPage()
                        break;
                    default:
                        AlertHelpers.showError(detail: response.responseCodeAndDesc)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func callZolozCofig(zolozFaceCaptureResponse : ZolozInitialFaceResponse) {
        DispatchQueue.main.async {
            let bizParam = NSMutableDictionary()
                bizParam[kZLZCurrentViewControllerKey] = self
            let request = ZLZRequest.init(zlzConfig: zolozFaceCaptureResponse.clientCfg ?? "", bizConfig: bizParam as! [AnyHashable : Any])
                ZLZFacade.sharedInstance().start(with: request) { response in
                        self.doZolozCheckFaceCaptureResult(zolozResponse : zolozFaceCaptureResponse)
                        print("=========>\(zolozFaceCaptureResponse.transactionId ?? "")")
               } interruptCallback: { response in
                         print("===>Error : \(String(format: "retcode:%@,extinfo:%@", response.retcode, response.extInfo))");
               }
               
        }
        
    }
    
    private func doZolozCheckFaceCaptureResult(zolozResponse : ZolozInitialFaceResponse) {
            let req = ZolozCheckResultFaceRequest(transactionId: zolozResponse.transactionId)
            self.viewModel.doZolozCheckFaceResult(req: req)
    }
    
    
    
    
    
    
}
