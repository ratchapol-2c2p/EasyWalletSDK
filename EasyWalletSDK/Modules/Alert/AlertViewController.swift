//
//  AlertViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 8/10/2567 BE.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var titleText: String?
    var detailText: String?
    var okTitle: String = "OK"
    var okAction: CompletionBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        titleLabel.text = titleText
        titleLabel.isHidden = titleText == nil
        
        detailLabel.text = detailText
        detailLabel.isHidden = detailText == nil
        
        okButton.setTitle(okTitle, for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .medium)
    }

    @IBAction func onTouchOkButton() {
        dismiss(animated: true)
        okAction?()
    }
}
