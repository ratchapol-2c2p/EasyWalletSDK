//
//  DatePickerDialogCustom.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 1/11/2567 BE.
//
import Foundation
import UIKit

private extension Selector {
    static let buttonTapped = #selector(DatePickerDialogCustom.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerDialogCustom.deviceOrientationDidChange)
}

open class DatePickerDialogCustom: UIView {
    public typealias DatePickerCallback = (Date?) -> Void

    // MARK: - Constants
    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 7
    private let kDoneButtonTag: Int = 1

    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    open var datePicker: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!

    // MARK: - Variables
    private var defaultDate: Date?
    private var datePickerMode: UIDatePicker.Mode?
    private var callback: DatePickerCallback?
    private var showCancelButton: Bool
    private var textColor: UIColor
    private var buttonColor: UIColor
    private var font: UIFont
    private var container: UIView?
    private lazy var gradient = CAGradientLayer()

    // MARK: - Dialog initialization
    @objc public init(
        textColor: UIColor = .black,
        buttonColor: UIColor = .black,
        font: UIFont = .boldSystemFont(ofSize: 15),
        showCancelButton: Bool = true
    ) {
        let size = UIScreen.main.bounds.size
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.font = font
        self.showCancelButton = showCancelButton
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        setupView()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        dialogView = createContainerView()
        backgroundColor = .white

        if let dialogView = dialogView {
            addSubview(dialogView)
        }
    }

    @objc func deviceOrientationDidChange(_ notification: Notification) {
        frame = UIScreen.main.bounds
        let dialogSize = CGSize(width: 300, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)
        dialogView.frame = CGRect(
            x: (UIScreen.main.bounds.size.width - dialogSize.width) / 2,
            y: (UIScreen.main.bounds.size.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        )
    }

    open func show(
        _ title: String,
        doneButtonTitle: String = "Done",
        cancelButtonTitle: String = "Cancel",
        defaultDate: Date = Date(),
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        datePickerMode: UIDatePicker.Mode = .dateAndTime,
        callback: @escaping DatePickerCallback
    ) {
        titleLabel.text = title
        doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton { cancelButton.setTitle(cancelButtonTitle, for: .normal) }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        let gregorianCalendar = Calendar(identifier: .gregorian)
        datePicker.calendar = gregorianCalendar
        datePicker.datePickerMode = datePickerMode
        datePicker.date = defaultDate
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self)
            NotificationCenter.default.addObserver(
                self,
                selector: .deviceOrientationDidChange,
                name: UIDevice.orientationDidChangeNotification, object: nil
            )

            UIView.animate(
                withDuration: 0.2,
                animations: {
                    self.backgroundColor = UIColor(white: 0, alpha: 0.4)
                    self.dialogView.layer.opacity = 1
                    self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            )
        }
    }

    private func close() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.backgroundColor = UIColor(white: 0, alpha: 0)
                self.dialogView.layer.opacity = 0
                self.dialogView.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1)
            }
        ) { _ in
            self.removeFromSuperview()
        }
    }

    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: 320, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)
        frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        let container = UIView(frame: CGRect(
            x: (screenSize.width - dialogSize.width) / 2,
            y: (screenSize.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        ))
        container.backgroundColor = .white
        container.layer.cornerRadius = kCornerRadius
        container.layer.masksToBounds = true
        container.layer.insertSublayer(gradient, at: 0)

        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.font = font.withSize(16)
        container.addSubview(titleLabel)

        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 300, height: 216))
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setValue(false, forKey: "textColor")
        datePicker.textColor = UIColor.init(colorName: .primary)
        container.addSubview(datePicker)

        addButtonsToView(container: container)
        return container
    }

    private func addButtonsToView(container: UIView) {
        let buttonWidth = container.bounds.width / (showCancelButton ? 2 : 1)
        if showCancelButton {
            cancelButton = createButton(title: "Cancel", frame: CGRect(
                x: 0, y: container.bounds.height - kDefaultButtonHeight,
                width: buttonWidth, height: kDefaultButtonHeight
            ))
            container.addSubview(cancelButton)
        }

        doneButton = createButton(title: "Done", frame: CGRect(
            x: showCancelButton ? buttonWidth : 0,
            y: container.bounds.height - kDefaultButtonHeight,
            width: buttonWidth, height: kDefaultButtonHeight
        ))
        doneButton.tag = kDoneButtonTag
        container.addSubview(doneButton)
    }

    private func createButton(title: String, frame: CGRect) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(buttonColor, for: .normal)
        button.titleLabel?.font = font.withSize(14)
        button.layer.cornerRadius = kCornerRadius
        button.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        return button
    }

    @objc func buttonTapped(sender: UIButton) {
        callback?(sender.tag == kDoneButtonTag ? datePicker.date : nil)
        close()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
