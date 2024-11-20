//
//  ViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 29/5/2567 BE.
//

import UIKit
import ObjectivePGP

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let pgp = PGPManager()
//        let encryptData = pgp.encrypt(data: ["email": "test@2c2p.com"])
//        print(encryptData ?? "")
//
//        
//        let decryptData = pgp.decrypt(data: "hQEMA7HUP/S/7UH8AQgAnia4nWMXcBomNdpUkyJirT3eyl5YE5NRvdRRWT51cMq35DW48QdKHCCU9mXjy41ERHiMVz1Zv0y6Tq0G8PBdmXxZBeolgSPrArVe6dhSJKTZsxbTu0scPjWE5poKasG7S9YWt7Tx1e4tRd4BtGouibMf6ZQtWK2QpDf47A6jHiUtdjDuZ95yF3YVzaVdwgDPmZeOGzOhmw0TpA1GX53mldCIuewNWvQITbSv3JNirW9yotLZ/42cGEm6vGt1J7XBH08ALZ6WwaIRfS5fH0BbqDznKlWu8JjjE3WDaFYa4peXQodckmF8ZSFnHnj3aO/lEGsC83d1R8SxTem0KI7hD9J8AXJCX3s5WHLNpXL8LHT63l9KZiG3P8WfS5RtuEF5Nxp9AXAtuQAtlvu9kzGPEuXUWGheHyUNcfN2g/hNeF75J7/IMruIuDW8Sm2jhGQvJfQLYLuwleLAOfypSg1cX9t8n2CVmAW7zVtEvWWq7rP1AHJH+X2sDKrZjfrw2w===ubhq")
//        print(decryptData ?? "")
        
        //AES256Helper.aes256(string: cardDetail?.cardNo ?? "")
        
//        let aes = AES256Manager()
//        let encryptData = aes.encrypt("testData1234")
//        print(encryptData ?? "");
//        
//        
//        let decryptData = aes.decrypt(encryptData ?? "")
//        print(decryptData);
        
        
//        OauthToken() { [weak self] in
//            self?.testAPI()
//        }
        
    }
    
    private func OauthToken(completion: @escaping CompletionBlock) {
        NetworkService.getOauthToken { oauthResponse in
            completion()
        } failureBlock: { error in
            print(error.localizedDescription)
        }
    }
    
    private func testAPI() {
        let req = VerifyUserByEmailRequest(email: "aaa@ss.com")
        NetworkService.requestApi(.verifyUserByEmail,
                                  request: req,
                                  completion: { (res: VerifyUserByEmailResponse) in
            print(res)
            
        }) { (error) in
            print(error)
        }
    }
}

