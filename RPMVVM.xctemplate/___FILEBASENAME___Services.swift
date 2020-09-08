//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_productName___Services {
    
    func exampleAPI(text1: String?, text2: String?) -> ___VARIABLE_productName___Model {
        guard let text1 = text1, let text2 = text2 else{
            var model = ___VARIABLE_productName___Model()
            model.error = APIError(message: "invalid input")
            return model
        }
        var model = ___VARIABLE_productName___Model()
        return model
    }
    
}
