//
//  AlertUtils.swift
//  TreeTableView
//
//  Created by Anwesh M on 03/12/21.
//

import UIKit

class Utils{
    
    static func showAlert(title: String = "", message: String ) {

        // create the alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
//        self.present(alert, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
