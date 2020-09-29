//
//  FlightsRouter.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class FlightsRouter: PRFlightsProtocol {
  
    static func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Flights", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "FlightsVC") as! FlightsVC
        
        var presenter: VPFlightsProtocol & IPFlightsProtocol = FlightsPresenter()
        let interactor: PIFlightsProtocol = FlightsInteractor()
        let router: PRFlightsProtocol = FlightsRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return vc
    }
    
    func showFilterModule(view: PVFlightsProtocol, delegate: FilterModuleDelegate, filter: String?) {
        if let target = view as? UIViewController {
            let vc = FilterRouter.createModule(delegate: delegate, filter: filter)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            target.present(vc, animated: true, completion: nil)
        }
        
    }
    
    func showErrorAlert(view: PVFlightsProtocol, with message: String) {
        if let view = view as? UIViewController {
            let alert = UIAlertController(title: "Error Occured", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            view.present(alert, animated: true)
        }
    }
}


