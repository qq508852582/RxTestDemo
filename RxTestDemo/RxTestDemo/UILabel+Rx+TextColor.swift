//
//  UILabel+Rx+TextColor.swift
//  RxTestDemo
//
//  Created by Jiang Xiaoming on 2019/9/5.
//  Copyright © 2019 Jiang Xiaoming. All rights reserved.
//

#if os(iOS) || os(tvOS)

import RxSwift
import RxCocoa

import UIKit

extension Reactive where Base: UILabel {
    
    /// Bindable sink for `text` property.
    public var textColor: Binder<UIColor?> {
        return Binder(self.base) { label, textColor in
            label.textColor = textColor
        }
    }
    
    
}

#endif
