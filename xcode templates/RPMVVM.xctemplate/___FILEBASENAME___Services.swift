//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import RampageMVVM

class ___VARIABLE_productName___Services: RPService {
    
    enum ___VARIABLE_productName___ServiceError : Error{
        case unknowError
        case networkError(String)
    }

    func exampleAPI(msg: String?) -> Result<___VARIABLE_productName___Model, ___VARIABLE_productName___ServiceError> {
        let result = http.get(url: "https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/mock_api.json")
        
        switch result {
        case .failure(let err):
            return .failure(.networkError(err.localizedDescription))
        case .success(let response):
            var model = ___VARIABLE_productName___Model()
            if model.set(json: response.text) {
                return .success(model)
            }
        }
        
        return .failure(.unknowError)
    }
    
}
