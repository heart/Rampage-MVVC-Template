//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageMVVM

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
                print($0, $1)
            }
        }

        viewModel.loading {
            print($0, $1)
        }

        presenter.event {
            if($0.name == "sendMessage"){
                if let eventData = $0.data as? [String: String]{
                    let message = eventData["message"]
                    self.callService(message: message)
                }
            }
        }
    }

    func callService(message: String?) {
        let req = ___VARIABLE_productName___ViewModel.___VARIABLE_productName___ServiceRequest(identifier: 999, message: message)
        viewModel.assign(request: req)
    }

}
