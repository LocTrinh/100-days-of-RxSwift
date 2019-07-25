//
//  ViewController.swift
//  RxCounter
//
//  Created by Trinh Loc on 7/24/19.
//  Copyright © 2019 Trinh Loc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshButton.rx.tap
            .map { _ in
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                dateformatter.timeStyle = .medium
                return dateformatter.string(from: Date())
            }
            .bind(to: dateTimeLabel.rx.text)
            .disposed(by: disposeBag)
    }


}

