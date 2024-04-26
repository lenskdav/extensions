//
//  File.swift
//  
//
//  Created by David Lenský on 28.12.2021.
//

import Foundation
import RxSwift

// -------------------------------------------------------------------------------
// MARK: - Observable.zip
// -------------------------------------------------------------------------------

extension Observable {

    public static func zip<O1: ObservableType, O2: ObservableType>(_ source1: O1,
                                                                   _ source2: O2)
    -> Observable<Element> where O1.Element == Element, O2.Element == Void {
            zip(source1, source2) { first, _ in first }
    }

    public static func zip<O1: ObservableType, O2: ObservableType>(_ source1: O1,
                                                                   _ source2: O2)
    -> Observable<O2.Element> where O1.Element == Void, O2.Element == Element {
            zip(source1, source2) { _, second in second }
    }

}

// -------------------------------------------------------------------------------
// MARK: - Observable.combineLatest
// -------------------------------------------------------------------------------

extension Observable {

    public static func combineLatest<O1: ObservableType, O2: ObservableType>(_ source1: O1,
                                                                             _ source2: O2)
    -> Observable<O1.Element> where O1.Element == Void, O2.Element == Void, Element == Void {
        combineLatest(source1, source2) { _, _ in () }
    }

    public static func combineLatest<O1: ObservableType, O2: ObservableType>(_ source1: O1,
                                                                             _ source2: O2)
    -> Observable<O1.Element> where O1.Element == Element, O2.Element == Void {
        combineLatest(source1, source2) { first, _ in first }
    }

    public static func combineLatest<O1: ObservableType, O2: ObservableType>(_ source1: O1,
                                                                             _ source2: O2)
    -> Observable<O2.Element> where O1.Element == Void, O2.Element == Element {
        combineLatest(source1, source2) { _, second in second }
    }

}

