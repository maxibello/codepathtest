//
//  CodePathTestTests.swift
//  CodePathTestTests
//
//  Created by Кузнецов Максим Алексеевич on 20.02.2023.
//

import XCTest
import CasePaths
@testable import CodePathTest

final class CodePathTestTests: XCTestCase {
    
    var sut = TestEnum.simple
    
    lazy var stringArray = Array.init(repeating: NSUUID().uuidString, count: 10000)
    
    
    func testWrite() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = .associated(token: "one")
                sut = .associated(token: "another")
            }
        }
    }
    
    func testWriteCasePath() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = (/TestEnum.associated).embed("one")
                sut = (/TestEnum.associated).embed("another")
            }
        }
    }
    
    //average: 0.003,
    //relative standard deviation: 22.248%,
    //values: [0.004192, 0.002556, 0.002541, 0.002451, 0.002314, 0.002291, 0.002279, 0.002257, 0.002263, 0.002213],
    func testReadValue() throws {
        self.measure {
            for str in stringArray {
                _ = TestEnum.associated(token: str)
            }
        }
    }
    
    //average: 0.054,
    //relative standard deviation: 3.698%,
    //values: [0.060376, 0.054277, 0.054189, 0.053953, 0.053868, 0.054024, 0.053942, 0.053567, 0.053585, 0.052781]
    func testReadValueCasePath() throws {
        self.measure {
            for str in stringArray {
                _ = (/TestEnum.associated).extract(from: TestEnum.associated(token: str))
            }
        }
    }
    
    
    
    //average: 0.006,
    //relative standard deviation: 9.625%,
    //values: [0.007120, 0.006494, 0.007388, 0.005965, 0.006335, 0.006009, 0.005813, 0.005740, 0.005634, 0.005542]
    func testWriteNestedRandom() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = .nestedAssociatedValue(.associated(token: Int.random(in: 0..<10000)))
            }
        }
    }
    
    //average: 0.036,
    //relative standard deviation: 9.462%,
    //values: [0.046156, 0.035391, 0.035412, 0.036484, 0.034741, 0.034587, 0.034694, 0.034102, 0.034661, 0.034633]
    func testWriteNestedRandomCasePath() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = (/TestEnum.nestedAssociatedValue..NestedEnum.associated).embed(Int.random(in: 0..<10000))
            }
        }
    }
    
    //average: 0.010,
    //relative standard deviation: 0.832%,
    //values: [0.010340, 0.010301, 0.010376, 0.010204, 0.010340, 0.010380, 0.010559, 0.010307, 0.010375, 0.010301]
    func testWriteNested2Random() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = .nestedAssociatedValue(.nestedAssociated(.associated(token: Int.random(in: 0..<10000))))
            }
        }
    }
    
    //average: 0.051,
    //relative standard deviation: 5.377%,
    //values: [0.057925, 0.049253, 0.050208, 0.050858, 0.050201, 0.051999, 0.050174, 0.052740, 0.047741, 0.048274]
    func testWriteNested2RandomCasePath() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = (/TestEnum.nestedAssociatedValue..NestedEnum.nestedAssociated..SecondNested.associated).embed(Int.random(in: 0..<10000))
            }
        }
    }
    
    //average: 0.013,
    //relative standard deviation: 12.306%,
    //values: [0.017242, 0.013185, 0.013001, 0.011721, 0.012978, 0.012285, 0.011530, 0.013916, 0.013884, 0.011492],
    func testWriteReferenceRandom() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = .associatedReference(TestReference(token: Int.random(in: 0..<10000)))
            }
        }
    }
    
    //average: 0.023,
    //relative standard deviation: 11.327%,
    //values: [0.029885, 0.023396, 0.023397, 0.024490, 0.023391, 0.022493, 0.020589, 0.020845, 0.021078, 0.021056]
    func testWriteReferenceRandomCasePath() throws {
        self.measure {
            for _ in 0..<10000 {
                sut = (/TestEnum.associatedReference).embed(TestReference(token: Int.random(in: 0..<10000)))
            }
        }
    }
    
    
}
