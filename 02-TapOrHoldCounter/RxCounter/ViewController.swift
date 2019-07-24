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

class ViewController: UIViewController {

    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var numberLabel: UILabel!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGesture = UILongPressGestureRecognizer()
        
        longPressGesture.rx.event
            .subscribe { [weak self] _ in
                guard let this = self else {
                    return
                }
                guard let text = this.numberLabel.text else {
                    return
                }
                guard let number = Int(text) else {
                    return
                }
                this.numberLabel.text = String(number + 1)
        }.disposed(by: disposeBag)
       
        self.tapButton.addGestureRecognizer(longPressGesture)
        
        tapButton.rx.tap.subscribe({ [weak self] _ in
            guard let this = self else {
                return
            }
            guard let text = this.numberLabel.text else {
                return
            }
            guard let number = Int(text) else {
                return
            }
            this.numberLabel.text = String(number+1)
        }).disposed(by: disposeBag)
        
        
        resetButton.rx.tap.subscribe { [weak self] _ in
            guard let this = self else {
                return
            }
            this.numberLabel.text = "0"
        }.disposed(by: disposeBag)
    }


}

