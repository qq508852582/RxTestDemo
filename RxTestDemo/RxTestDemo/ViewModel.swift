//
//  ViewModel.swift
//  RxTestDemo
//
//  Created by Jiang Xiaoming on 2019/9/5.
//  Copyright © 2019 Jiang Xiaoming. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    public let disposeBag = DisposeBag()
    public let rx_numberLabelText=BehaviorRelay(value: "")
    public let rx_numberLabelTextColor=BehaviorRelay(value: UIColor.black)
    
    private var rx_number = BehaviorRelay(value: 0)
    
    init() {
//        rx_numberLabelText = BehaviorRelay(value: "")
        rx_number.map{"当前数字: \($0)"}.bind(to:rx_numberLabelText).disposed(by: disposeBag)
        rx_number.map{$0 > 10 ?UIColor.red:UIColor.black}.bind(to:rx_numberLabelTextColor).disposed(by: disposeBag)
    }
    
    public func addButtonAction(){
        rx_number.accept(rx_number.value +  1 )
//        print("+1")
    }
    public func subtractButtonAction(){
        rx_number.accept(rx_number.value - 1  )
    }
}
