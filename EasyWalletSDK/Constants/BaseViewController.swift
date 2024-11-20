//
//  BaseViewController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation
import Combine

class BaseViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    }
    
    func configureNavigationBar(
        title: String?,
        titleColor: UIColor = UIColor(colorName: .black) ?? .black,
        tintColor: UIColor = UIColor(colorName: .black) ?? .black,
        navigationBarColor: UIColor = UIColor(colorName: .white) ?? .white,
        backButtonTitle: String? = nil,
        backButtonImage: UIImage? = nil,
        isShadow: Bool = true
    ) {
        // สร้าง UINavigationBarAppearance สำหรับตั้งค่ารูปลักษณ์ของ NavigationBar
        let appearance = UINavigationBarAppearance()
        
        // ตั้งค่า background ของ NavigationBar
        appearance.backgroundColor = navigationBarColor
        
        // ตั้งค่า title
        if let title = title {
            navigationItem.title = title
        }
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        
        // กำหนด appearance ให้กับ NavigationBar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // ตั้งค่าปุ่ม Back
        if let backButtonTitle = backButtonTitle {
            let backButton = UIBarButtonItem(title: backButtonTitle, style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        } else if let backButtonImage = backButtonImage {
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        } else {
            let backButtonImage = UIImage(named: "chevron.left") ?? UIImage(systemName: "chevron.left")
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
        
        // ตั้งค่าสีปุ่มใน NavigationBar (tintColor)
        navigationController?.navigationBar.tintColor = tintColor
        
        // เพิ่มเงาด้านล่างของ NavigationBar ถ้าจำเป็น
        if isShadow {
            navigationController?.addBottomShadowToNavigationBar()
        }
    }
    
    @objc func backButtonTapped() {
        // ดำเนินการ pop กลับไปยัง view controller ก่อนหน้า
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

extension UINavigationBar {
    func addShadow(
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.3,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowRadius: CGFloat = 4
    ) {
        // กำหนดค่าเงาให้กับ navigationBar layer
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        // เปิดการแสดงผลเงา
        self.layer.masksToBounds = false
    }
}

extension UINavigationController {
    func addBottomShadowToNavigationBar(
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.3,
        shadowOffset: CGSize = CGSize(width: 0, height: 3),
        shadowRadius: CGFloat = 4
    ) {
        // สร้าง UIView สำหรับแสดงเงา
        let shadowView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.height, width: navigationBar.frame.width, height: 4))
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.masksToBounds = false

        // เพิ่ม shadowView ด้านล่างของ navigationBar
        navigationBar.addSubview(shadowView)
    }
}
