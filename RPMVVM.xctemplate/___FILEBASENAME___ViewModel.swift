//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageFramework

class ___VARIABLE_productName___ViewModel: RPViewModel {

    let service = ___VARIABLE_productName___Services()

    struct ___VARIABLE_productName___ServiceRequest: RPServiceRequest {
        var identifier: Int = 0
        var message: String?
    }

    override func onRequest(request: RPServiceRequest) {
        if let request = request as? ___VARIABLE_productName___ServiceRequest {
            exampleAPI(request: request)
        }
    }
    
    func exampleAPI(request: ___VARIABLE_productName___ServiceRequest) {
        RP.async {
            self.dispatch(isLoading: true, request: request)
            let resultModel = self.service.exampleAPI(msg: request.message)
            RP.main{
                self.dispatch(isLoading: false, request: request)
                self.dispatch(model: resultModel, request: request)
            }
        }
    }

}
