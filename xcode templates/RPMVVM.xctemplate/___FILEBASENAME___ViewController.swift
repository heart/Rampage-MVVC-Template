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

    let exampleServiceID = UUID()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(viewController: self)
    }

    override func bind() {
        viewModel.onSuccess { model, req in
            if req.identifier == self.exampleServiceID {
                if let model = model as? ___VARIABLE_productName___Model{
                    let movieName = model.json?["movie"].string ?? ""
                    let firstName = model.json?["firstname"].string ?? ""
                    let lastName = model.json?["lastname"].string ?? ""
                    let description = model.json?["description"].string ?? ""

                    print(movieName)
                    print(lastName, firstName)
                    print(description)
                }
            }
        }

        viewModel.onFail{ err, req in
            if req.identifier == self.exampleServiceID {
                print(err)
            }
        }

        viewModel.loading {
            print($0, $1)
        }

        presenter.event {
            if($0.name == "fetchMovieData"){
                if let eventData = $0.data as? [String: String]{
                    let message = eventData["message"]
                    self.callService(message: message)
                }
            }
        }
    }

    func callService(message: String?) {
        let req = ___VARIABLE_productName___ViewModel.___VARIABLE_productName___ServiceRequest(identifier: exampleServiceID, message: message)
        viewModel.assign(request: req)
    }

}
