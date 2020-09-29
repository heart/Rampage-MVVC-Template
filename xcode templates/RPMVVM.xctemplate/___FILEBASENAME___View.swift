//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageMVVM

class ___VARIABLE_productName___View: RPPresenter {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func onStart(){
        loadLanguage(file: "___VARIABLE_productName___-lang.json")
        
        // You can access viewController here
        viewController?.view?.backgroundColor = UIColor.red
    }

    @IBAction func clickLogin(_ sender: Any) {
        let data = ["message": "Hello, World!"]
        let event = RPEvent(name: "fetchMovieData", data: data)
        dispatch(event: event)
    }
    
}
