//
//  CustomTextField.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 15/10/2567 BE.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CustomTextField: UIView {
    
    public var textField: MDCOutlinedTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // ตั้งค่าเริ่มต้นที่ต้องการ เช่น background color หรือเพิ่ม subviews
        textField = MDCOutlinedTextField(frame: self.frame)
        
        setOutlineColor(UIColor(colorName: .primary), state: .editing)
        setOutlineColor(UIColor(colorName: .gray), state: .normal)
        
        setTextColor(UIColor(colorName: .black), state: .editing)
        setTextColor(UIColor(colorName: .black), state: .normal)
        
        setTitleColor(UIColor(colorName: .primary), state: .editing)
        setTitleColor(.darkGray, state: .normal)
        
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.leadingAssistiveLabel.font = UIFont.systemFont(ofSize: 10)
        
//        textField.sizeToFit()
        textField.adjustsFontSizeToFitWidth = false
        textField.adjustsFontForContentSizeCategory = false
//        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        setPlaceholderColor(.lightGray, state: .normal)
        setPlaceholderColor(UIColor(colorName: .primary), state: .editing)
        
        
      
        self.addSubview(textField)
//
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        
        print("Screen Width: ", UIScreen.main.bounds.width)
        print("View Width: ", self.frame.width)
        print("text Width: ", textField.frame.width)
        
//        textField.addTarget(self,
//                            action: #selector(textFieldDidChange),
//                            for: .editingChanged)
    }
    
    public func setTitleText(_ text: String) {
        textField.label.text = text
    }
    
    public func setPlaceholderText(_ text: String) {
        textField.placeholder = text
        
    }
    
    public func setOutlineColor(_ color: UIColor?, state: MDCTextControlState) {
        textField.setOutlineColor(color ?? .black, for: state)
    }
    
    public func setTitleColor(_ color: UIColor?, state: MDCTextControlState) {
        if state == .normal {
            textField.setNormalLabelColor(color ?? .black, for: .normal)
        } else if state == .editing {
            textField.setFloatingLabelColor(color ?? .black,
                                            for: .editing)
        }
    }
    
    public func setTextColor(_ color: UIColor?, state: MDCTextControlState) {
        textField.setTextColor(color ?? .black, for: state)
    }
    
    public func setTrailingView(_ view: UIView, color: UIColor = .gray) {
//        let trailingIcon = UIImageView(image: UIImage(systemName: "eye"))
//        trailingIcon.tintColor = .gray
        textField.trailingView = view
        textField.trailingViewMode = .always
    }
    
    public func setTrailingImage(_ image: UIImage, color: UIColor = .gray,width: CGFloat = 24, height: CGFloat = 24) {
        let trailingIcon = UIImageView(image: image)
        trailingIcon.tintColor = color
        trailingIcon.contentMode = .scaleAspectFit
        trailingIcon.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        textField.trailingView = trailingIcon
        textField.trailingViewMode = .always
    }
    
    public func setErrorMessage(text: String, color: UIColor = .red) {
        textField.trailingAssistiveLabel.text = text
        textField.setTrailingAssistiveLabelColor(color, for: .normal)
        textField.setTrailingAssistiveLabelColor(color, for: .editing)
    }
    
    // ฟังก์ชันนี้สามารถใช้สำหรับการกำหนด layout ของ subviews ต่างๆ ใน custom view ของคุณ
    override func layoutSubviews() {
        super.layoutSubviews()
        // จัดการ layout ที่กำหนดเอง
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setErrorMessage(text: "")
//            viewModel.setEmail(textField.text ?? "")
    }
    
    public func setPlaceholderColor(_ color: UIColor?, state: MDCTextControlState) {
        if state == .normal {
            textField.setNormalLabelColor(color ?? .black, for: .normal)
        } else if state == .editing {
            textField.setFloatingLabelColor(color ?? .black, for: .editing)
        }
    }
}
