//
//  ViewController.swift
//  RxCounter
//
//  Created by Trinh Loc on 7/24/19.
//  Copyright © 2019 Trinh Loc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    fileprivate let disposeBag = DisposeBag()
    
    let doneButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "Done"
        item.style = .done
        return item
    }()
    
    var principal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        doneButton.rx.tap.subscribe {[weak self] _ in
            guard let this = self else {
                return
            }
            guard let numberTextLable = this.numberTextField.text else {
                return
            }
            guard !numberTextLable.isEmpty else {
                return
            }
            guard let number  = Double(numberTextLable)?.roundToPlaces(2) else {
                return
            }
            this.principal = number
            this.numberTextField.text = "$\(String(format: "%.2f", this.principal))"
            this.calculator()
            this.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        
        slider.rx.value.subscribe {
            [weak self] _ in
            guard let this = self else {
                return
            }
            this.calculator()
            
            }
            .disposed(by: disposeBag)
        
        numberTextField.rx.controlEvent(.touchDown)
            .subscribe { [weak self] _ in
                guard let this = self else {
                    return
                }
                this.numberTextField.text = ""
                
            }.disposed(by: disposeBag)
        
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items = [doneButton]
        numberToolbar.sizeToFit()
        
        numberTextField.inputAccessoryView = numberToolbar
        
    }

    func calculator() {
        let percent = Double(slider.value).roundToPlaces(2)
        percentLabel.text = "(\(String(format: "%.0f", percent * 100))%)"
        tipLabel.text = "$\(String(format: "%.2f",principal * percent))"
        guard let number = Double(String(format: "%.2f",principal * percent)) else {
            return
        }
        totalLabel.text = "$\(principal + number)"
    }
}

