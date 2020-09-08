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
    
    func exampleAPI(text1: String?, text2: String?) {
        RP.async {
            self.dispatch(isLoading: true)
            let resultModel = self.service.exampleAPI(text1: text1, text2: text2)
            RP.main{
                self.dispatch(isLoading: false)
                self.dispatch(model: resultModel)
            }
        }
    }

    
}
