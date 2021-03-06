//
//  DialogHandler.swift
//  Base Utils
//
//  Created by Dat Ng on 2/23/18.
//  Copyright © 2018 datnm (laohac83x@gmail.com). All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    convenience init(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert) {
        self.init(title: title, message: message, preferredStyle: style)
    }

    @discardableResult
    func addAction(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
        return action
    }
}


open class LHDialogHandler {
    @discardableResult
    open class func showAlert(title: String? = nil, message: String?,
                                     button: String = "OK",
                                     tintColor: UIColor? = nil,
                                     onVC: UIViewController? = nil, buttonHandler:(() -> Void)? = nil) -> UIAlertController? {
        if (String.isEmpty(title, trimCharacters: .whitespacesAndNewlines) && String.isEmpty(message, trimCharacters: .whitespacesAndNewlines)) || String.isEmpty(button, trimCharacters: .whitespacesAndNewlines) {
            return nil
        }

        if let onPresentController = onVC ?? UIApplication.shared.keyWindow?.rootViewController?.topMostViewController {
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertViewController.addAction(UIAlertAction(title: button, style: .default, handler: { (alertAction) in
                buttonHandler?()
            }))

            if let tinColor = tintColor { alertViewController.view.tintColor = tinColor }
            onPresentController.present(alertViewController, animated: true, completion: nil)
            return alertViewController
        }

        return nil
    }

    @discardableResult
    open class func showDialogConfirm(title: String? = nil, message: String?,
                          btnOK: String = "OK", btnCancel: String = "Cancel",
                          tintColor: UIColor? = nil,
                          onVC: UIViewController? = nil, buttonHandler:((String) -> Void)? = nil) -> UIAlertController? {

        if (String.isEmpty(title, trimCharacters: .whitespacesAndNewlines) && String.isEmpty(message, trimCharacters: .whitespacesAndNewlines)) {
            return nil
        }

        if (String.isEmpty(btnOK, trimCharacters: .whitespacesAndNewlines) && String.isEmpty(btnCancel, trimCharacters: .whitespacesAndNewlines)) {
            return nil
        }

        if let onPresentController = onVC ?? UIApplication.shared.keyWindow?.rootViewController?.topMostViewController {
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertViewController.addAction(UIAlertAction(title: btnOK, style: .default, handler: { (alertAction) in
                buttonHandler?(btnOK)
            }))

            alertViewController.addAction(UIAlertAction(title: btnCancel, style: .default, handler: { (alertAction) in
                buttonHandler?(btnCancel)
            }))

            if let tinColor = tintColor { alertViewController.view.tintColor = tinColor }
            onPresentController.present(alertViewController, animated: true, completion: nil)
            return alertViewController
        }

        return nil
    }
}
