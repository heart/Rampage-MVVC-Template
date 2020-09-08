//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageFramework

class ___VARIABLE_productName___View: RPPresenter {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    @IBAction func clickLogin(_ sender: Any) {
        let event = RPEvent(name: "login", data:
            [
                "user": userText.text,
                "password": passText.text
            ])
        dispatch(event: event)
    }
    
}
