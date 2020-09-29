//
//  FilterRouter.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class FilterRouter: PRFilterProtocol {
    
    static func createModule(delegate: FilterModuleDelegate, filter: String?) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Filter", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        
        var presenter: VPFilterProtocol & IPFilterProtocol & SegueDataProtocol = FilterPresenter()
        let interactor: PIFilterProtocol = FilterInteractor()
        let router: PRFilterProtocol = FilterRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        presenter.filter = filter
    
        return vc
    }
    
    func dismiss(view: PVFilterProtocol) {
        if let view = view as? UIViewController {
            view.dismiss(animated: false, completion: nil)
        }
    }
}
