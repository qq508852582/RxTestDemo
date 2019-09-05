//
//  RxTestDemoTests.swift
//  RxTestDemoTests
//
//  Created by Jiang Xiaoming on 2019/9/5.
//  Copyright © 2019 Jiang Xiaoming. All rights reserved.
//

import XCTest
import RxTest
import RxSwift

@testable import RxTestDemo

class RxTestDemoTests: XCTestCase {
    let viewModel = ViewModel()
    var disposeBag = DisposeBag()
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdd() {
        let scheduler = TestScheduler(initialClock: 0)

        let textColorObserver = scheduler.createObserver(UIColor.self)
        self.viewModel.rx_numberLabelTextColor
            .subscribe(textColorObserver)
            .disposed(by: disposeBag)
        
        let textObserver = scheduler.createObserver(String.self)
        self.viewModel.rx_numberLabelText
            .subscribe(textObserver)
            .disposed(by: disposeBag)
        
        let inputNumber = scheduler.createHotObservable([Recorded.next(100, (1)),
                                                         Recorded.next(200, (1)),
                                                         Recorded.next(300, (1)),
                                                         Recorded.next(400, (1)),
                                                         Recorded.next(500, (1)),
                                                         Recorded.next(600, (1)),
                                                         Recorded.next(700, (1)),
                                                         Recorded.next(800, (1)),
                                                         Recorded.next(900, (1)),
                                                         Recorded.next(1000, (1)),
                                                         Recorded.next(1100, (1)),
                                                         Recorded.next(1200, (-1)),
                                                         Recorded.next(1300, (-1)),
            ])

        inputNumber.subscribe(onNext: { [weak self](n) in
            if(n == 1){
                self?.viewModel.addButtonAction()
            }
            else{
                self?.viewModel.subtractButtonAction()
            }
        }).disposed(by: disposeBag)
        
        scheduler.start()
        
        let expectedtextEvents = [
            Recorded.next(0, ("当前数字: 0")),
            Recorded.next(100, ("当前数字: 1")),
            Recorded.next(200, ("当前数字: 2")),
            Recorded.next(300, ("当前数字: 3")),
            Recorded.next(400, ("当前数字: 4")),
            Recorded.next(500, ("当前数字: 5")),
            Recorded.next(600, ("当前数字: 6")),
            Recorded.next(700, ("当前数字: 7")),
            Recorded.next(800, ("当前数字: 8")),
            Recorded.next(900, ("当前数字: 9")),
            Recorded.next(1000, ("当前数字: 10")),
            Recorded.next(1100, ("当前数字: 11")),

            Recorded.next(1200, ("当前数字: 10")),
            Recorded.next(1300, ("当前数字: 9"))]
        
        XCTAssertEqual(textObserver.events, expectedtextEvents)

        let expectedtextColorEvents = [
            Recorded.next(0, (UIColor.black)),
            Recorded.next(100, (UIColor.black)),
            Recorded.next(200, (UIColor.black)),
            Recorded.next(300, (UIColor.black)),
            Recorded.next(400, (UIColor.black)),
            Recorded.next(500, (UIColor.black)),
            Recorded.next(600,(UIColor.black)),
            Recorded.next(700, (UIColor.black)),
            Recorded.next(800, (UIColor.black)),
            Recorded.next(900, (UIColor.black)),
            Recorded.next(1000, (UIColor.black)),
            Recorded.next(1100, (UIColor.red)),
            
            Recorded.next(1200, (UIColor.black)),
            Recorded.next(1300, (UIColor.black)),

        ]
        XCTAssertEqual(textColorObserver.events, expectedtextColorEvents)

    }
}
