//
//  FilterVC.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var backgrounButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: - Properties
    var presenter: VPFilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotification()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateFilterView(isOpen: true, completion: nil)
    }
    
    deinit {
        deRegisterKeyboardNotification()
    }
    
    private func configureUI() {
        filterViewBottomConstraint.constant = -filterView.frame.height
        self.view.layoutIfNeeded()
        
        filterTextField.text = presenter?.getInitialFilter()
        
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1)
        clearButton.layer.borderWidth = 1
        
        filterButton.layer.cornerRadius = filterButton.frame.height / 2
    }
    
    @IBAction func backgroundButtonTapped(_ sender: Any) {
        animateFilterView(isOpen: false) { [weak self] in
            self?.presenter?.dismiss()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        animateFilterView(isOpen: false) { [weak self] in
            self?.presenter?.onFilter(with: nil)
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        animateFilterView(isOpen: false) { [weak self] in
            guard let self = self else { return }
            guard let country = self.filterTextField.text else { return }
            self.presenter?.onFilter(with: country)
        }
    }
    
    private func animateFilterView(isOpen: Bool, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            let constant = isOpen ? 0 : -self.filterView.frame.height
            let alpha: CGFloat = isOpen ? 0.4 : 0
            self.filterViewBottomConstraint.constant = constant
            self.backgrounButton.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (_) in
            completion?()
        }
    }
}

extension FilterVC: PVFilterProtocol {

}

extension FilterVC: KeyboardFeature {
    
    func keyboardWillOpen(height: CGFloat) {
        filterViewBottomConstraint.constant = height
        self.view.layoutIfNeeded()
    }
    
    func keyboardWillClose() {
        filterViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
}
