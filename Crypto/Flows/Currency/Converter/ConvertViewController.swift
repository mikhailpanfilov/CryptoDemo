//
//  ConvertViewController.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/3/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import UIKit

class ConvertViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var convertContainerView: UIView!
    @IBOutlet weak var convertTextField: UITextField!
    @IBOutlet weak var convertSymbolLablel: UILabel!
    @IBOutlet weak var convertNameLablel: UILabel!
    @IBOutlet weak var swapCurrencyLabel: UIButton!
    @IBOutlet weak var swapCurrencyButton: UIButton!
    @IBOutlet weak var resultContainerView: UIView!
    @IBOutlet weak var resultLabel: CountingLabel!
    @IBOutlet weak var resultSymbolLablel: UILabel!
    @IBOutlet weak var resultNameLablel: UILabel!
    
    // MARK: Properties
    
    var presenter: ConvertPresentation!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Public methods
    
    func set(_ presenter: ConvertPresentation) {
        self.presenter = presenter
    }
    
    // MARK: Private methods
    
    private func configure() {
        presenter.populateView()
        convertTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        convertTextField.becomeFirstResponder()
    }
    
    private func setConvertBlockAlpha(_ alpha: CGFloat) {
        self.convertTextField.alpha = alpha
        self.convertSymbolLablel.alpha = alpha
        self.convertNameLablel.alpha = alpha
    }
    
    private func setResultBlockAlpha(_ alpha: CGFloat) {
        self.resultLabel.alpha = alpha
        self.resultSymbolLablel.alpha = alpha
        self.resultNameLablel.alpha = alpha
    }
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        presenter.convertPrice(convertTextField.text, presenter.toFiat)
    }
    
    // MARK: IBActions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        presenter.onDismissAction()
    }
    
    @IBAction private func switchCurrencyTouchUpInside(_ sender: UIButton) {
        presenter.toFiat = !presenter.toFiat
        presenter.segmentedChangedValue(presenter.toFiat, convertPrice: convertTextField.text ?? "", resultPrice: resultLabel.text ?? "")
    }
}

// MARK: PriceListView

extension ConvertViewController: ConvertInterface {
    func populateView(name: String, symbol: String) {
        convertNameLablel.text = name.uppercased()
        convertSymbolLablel.text = symbol
    }
    
    func populateConvertBlock(price: String, symbol: String, name: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.setConvertBlockAlpha(0)
        }, completion: { _ in
            self.convertTextField.text = price.numeric
            self.convertSymbolLablel.text = symbol
            self.convertNameLablel.text = name
        })
        UIView.animate(withDuration: 0.6, animations: {
            self.setConvertBlockAlpha(1)
        })
    }
    
    func populateResultBlock(result: String, symbol: String, name: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.setResultBlockAlpha(0)
        }, completion: { _ in
            self.resultLabel.text = result
            self.resultSymbolLablel.text = symbol
            self.resultNameLablel.text = name.uppercased()
        })
        UIView.animate(withDuration: 0.6, animations: {
            self.setResultBlockAlpha(1)
        })
    }
    
    func setConvertedPrice() {
        if presenter.convertedPrice == 0 {
            resultLabel.text = "0"
        } else if presenter.convertedPrice <= presenter.maxValue {
            resultLabel.text = "<\(presenter.maxValue)"
        } else {
            resultLabel.decimalPoints = presenter.toFiat ? .two : .three
            resultLabel.count(from: 0, to: presenter.convertedPrice, duration: .custom)
        }
    }
}

// MARK: Transitioning

extension ConvertViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ConvertPresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ConvertDismissAnimationController()
    }
}
