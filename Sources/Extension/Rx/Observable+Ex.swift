//
//  Observable+Ex.swift
//  Components
//
//  Created by Lazyman on 12/31/22.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in
            print("return map to void")
        }
    }
}
