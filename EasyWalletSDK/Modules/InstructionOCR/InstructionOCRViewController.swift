//
//  RegisterByEmailViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import UIKit
import hummer
class InstructionOCRViewController: BaseViewController {
    
    @IBOutlet weak var radioThaiImageView: UIImageView!
    @IBOutlet weak var radioNonThaiImageView: UIImageView!
    @IBOutlet weak var thaiIdCardImageView: UIImageView!
    @IBOutlet weak var passportImageView: UIImageView!
    var router: InstructionOCRRouter!
    var viewModel: InstructionOCRModel!
    var isSelectThai: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar(title: "Pre-Registration")
        router = InstructionOCRRouter(self)
        viewModel = InstructionOCRModel()
        setupUI()
        bindViewModel()
    }
    
    @IBAction func onTouchThai(_ sender: Any) {
        isSelectThai = true
        SessionHelper.shared.isThai = true
        onSelectOption();
    }
    
    @IBAction func onTouchNonThai(_ sender: Any) {
        isSelectThai = false
        SessionHelper.shared.isThai = false
        onSelectOption();
      
    }
    @IBAction func onTouchAcceptButton(_ sender: Any) {
        let metainfo = ZLZFacade.getMetaInfo()
        let encryptedEmail = AES256Manager.encrypt(SessionHelper.shared.email ?? "")
        let docType = isSelectThai ? "00660000001" : "00000001003"
        let req = ZolozInitialRequest(metaInfo: metainfo, userId: encryptedEmail, docType: docType)
        viewModel.initialZoloz(req: req)
     
    }
    
    private func setupUI() {
        isSelectThai = true
        SessionHelper.shared.isThai = true
        onSelectOption();

    }
    
    private func onSelectOption() {
    
        let radioActive = UIImage(imageNames: .radioActiveIcon)
        let radioInActive = UIImage(imageNames: .radioInActiveIcon)
    
        radioThaiImageView.image = isSelectThai ? radioActive:radioInActive
        radioNonThaiImageView.image = isSelectThai ? radioInActive:radioActive
    
        let imgThai = UIImage(imageNames: .thaiIdCardImage)
        let imgPassPort = UIImage(imageNames: .passPortImage)
    
        thaiIdCardImageView.image = isSelectThai ? imgThai : imgThai?.grayed(CIColor(cgColor: UIColor.lightGray.cgColor))
        passportImageView.image = isSelectThai ? imgPassPort?.grayed(CIColor(cgColor: UIColor.lightGray.cgColor)) : imgPassPort

}
    
    private func bindViewModel() {
        viewModel.$zolozresponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] zolozInitial in
                guard self != nil else {return}
                if let response = zolozInitial {
                    switch response.responseCode {
                    case "000":
                        self?.callZolozCofig(zolozResponse: response)
                        break;
                    default:
                        AlertHelpers.showError(detail: response.responseCodeAndDesc)
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.$zolozCheckResultResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] zolozCheckResult in
                guard self != nil else {return}
                if let response = zolozCheckResult {
                    switch response.responseCode {
                    case "000":
                        SessionHelper.shared.zolozIdInfo = response.idInfo
                        self?.router.toSelfiePage()
                        break;
                    default:
                        AlertHelpers.showError(detail: response.responseCodeAndDesc)
                    }
                   
                }
            }
            .store(in: &cancellables)
    }
    
    private func callZolozCofig(zolozResponse : ZolozInitialResponse) {
        DispatchQueue.main.async {
            let bizParam = NSMutableDictionary()
                bizParam[kZLZCurrentViewControllerKey] = self
            let request = ZLZRequest.init(zlzConfig: zolozResponse.clientCfg ?? "", bizConfig: bizParam as! [AnyHashable : Any])
                ZLZFacade.sharedInstance().start(with: request) { response in
                        self.doZolozCheckResult(zolozResponse : zolozResponse)
                  
               } interruptCallback: { response in
                   
                        print("===>Error : \(String(format: "retcode:%@,extinfo:%@", response.retcode,response.extInfo))");
                    
               }
        }
       
           
    }
    
    private func doZolozCheckResult(zolozResponse : ZolozInitialResponse) {
            let req = ZolozCheckResultRequest(transactionId: zolozResponse.transactionId)
            self.viewModel.doGetZolozCheckResult(req: req)
    }
    
    
    
    
    
    
    
    
    
        
}
