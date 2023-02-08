//
//  UIView+Rx.swift
//  Extensions
//
//  Created by David Lenský on 24/08/2019.
//  Copyright © 2019 David Lenský. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIView {

    public var transform: Binder<CGAffineTransform> {
        return Binder(self.base) { view, transform in
            view.transform = transform
        }
    }

    public var height: Binder<CGFloat> {
        return Binder(self.base) { view, height in
            view.frame.size = CGSize(w: view.width, h: height)
        }
    }

}

extension ObservableType {

    public func layoutIfNeeded(_ view: UIView) -> Observable<Element> {
        self.do(onNext: { [weak view] _ in view?.layoutIfNeeded() })
    }

}
