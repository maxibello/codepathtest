//
//  TestEnum.swift
//  CodePathTest
//
//  Created by Кузнецов Максим Алексеевич on 20.02.2023.
//

import Foundation

enum TestEnum {
    case simple
    case simple2
    case associated(token: String)
    case nestedAssociatedValue(NestedEnum)
    case associatedReference(TestReference)
}

enum NestedEnum {
    case associated(token: Int)
    case nestedAssociated(SecondNested)
}

enum SecondNested {
    case associated(token: Int)
    case nestedAssociated(ThirdNested)
}

enum ThirdNested {
    case associated(sToken: String)
    case nestedAssociated(ForthNested)
}

enum ForthNested {
    case associated(sToken: String)
}

class TestReference {
    let token: Int
    
    init(token: Int) {
        self.token = token
    }
}
