//
//  RPViewController.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

#if !os(macOS)

import UIKit

open class RPViewController: UIViewController {
    
    var info:[String:Any]?

    open override func loadView() {
        let xibFileName = String(describing: type(of: self))
        if let nib = Bundle.main.loadNibNamed(xibFileName, owner: self),
           let nibView = nib.first as? UIView {
            view = nibView
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    open func bind(){
        
    }
    
}

#endif
