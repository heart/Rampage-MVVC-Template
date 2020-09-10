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
    
    override func onStart(){
        // You can access viewController from here
        viewController?.view?.backgroundColor = UIColor.red
    }

    @IBAction func clickLogin(_ sender: Any) {
        let data = ["message": "Hello, World!"]
        let event = RPEvent(name: "sendMessage", data: data)
        dispatch(event: event)
    }
    
}
