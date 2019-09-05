//
//  ViewController.swift
//  RxTestDemo
//
//  Created by Jiang Xiaoming on 2019/9/5.
//  Copyright © 2019 Jiang Xiaoming. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let viewModel = ViewModel()
    
    public let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.rx.tap
            .subscribe(onNext:{[weak self ] in  self?.viewModel.addButtonAction()})
            .disposed(by: disposeBag)
        
        subtractButton.rx.tap
            .subscribe(onNext:{[weak self ] in self?.viewModel.subtractButtonAction()})
            .disposed(by: disposeBag)
        
        viewModel.rx_numberLabelText.asDriver().drive(numberLabel.rx.text).disposed(by: disposeBag)
        viewModel.rx_numberLabelTextColor.asDriver().drive(numberLabel.rx.textColor).disposed(by: disposeBag)
//        numberLabel.rx.
        // Do any additional setup after loading the view.
    }
}

