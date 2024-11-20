//
//  CustomButton.swift
//  Alamofire
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import UIKit

class CustomButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        self.titleLabel?.adjustsFontForContentSizeCategory = false
//        let text = self.titleLabel?.text
//        let font = self.titleLabel?.font
//        print(font)
//    }
    

}

extension UIButton {

    @IBInspectable
    var adjustsFontForContentSizeCategory: Bool {
        set {
            self.titleLabel?.adjustsFontForContentSizeCategory = newValue
        }
        get {
            return self.titleLabel?.adjustsFontForContentSizeCategory ?? false
        }
    }
}

class CustomView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // ใช้ layoutSubviews เพื่ออัปเดตการตั้งค่าทุกครั้งที่ view เปลี่ยนแปลง
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
}
