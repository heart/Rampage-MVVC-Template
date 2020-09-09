//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageFramework

class ___VARIABLE_productName___ViewController: RPViewController {
    
    @IBOutlet var presenter: ___VARIABLE_productName___View!
    let viewModel = ___VARIABLE_productName___ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(viewController: self)
    }

    override func bind() {
        viewModel.watch {
            if $0 is ___VARIABLE_productName___Model {
                print($0)
            }
        }

        viewModel.loading {
            print($0)
        }

        presenter.event {
            if($0.name == "login"){
                if let loginData = $0.data as? [String: String]{
                    
                    let user = loginData["user"]
                    let password = loginData["password"]
                    
                    self.callService(user: user, pass: password)
                }
                
            }
        }
    }

    func callService(user: String?, pass: String?) {
        viewModel.exampleAPI(text1: user, text2: pass)
    }

}
