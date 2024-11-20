//
//  Untitled.swift
//  Pods
//
//  Created by Tanawat Arthan on 8/11/2567 BE.
//

extension UIDatePicker {

var textColor: UIColor? {
    set {
        setValue(newValue, forKeyPath: "textColor")
    }
    get {
        return value(forKeyPath: "textColor") as? UIColor
    }
  }
}
