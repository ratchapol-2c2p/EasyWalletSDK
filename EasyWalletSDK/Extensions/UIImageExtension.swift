//
//  UIImageExtension.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 17/10/2567 BE.
//

import Foundation

extension UIImage {
    var grayed: (CIColor) -> UIImage {
        {
            guard let ciImage = CIImage(image: self) else { return self }
            let filterParameters = [ kCIInputColorKey: $0, kCIInputIntensityKey: 1.0 ] as [String: Any]
            let grayscale = ciImage.applyingFilter("CIColorMonochrome", parameters: filterParameters)
            return UIImage(ciImage: grayscale)
        }
    }
    func resized(to size: CGSize) -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
           draw(in: CGRect(origin: .zero, size: size))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return resizedImage
       }
}
