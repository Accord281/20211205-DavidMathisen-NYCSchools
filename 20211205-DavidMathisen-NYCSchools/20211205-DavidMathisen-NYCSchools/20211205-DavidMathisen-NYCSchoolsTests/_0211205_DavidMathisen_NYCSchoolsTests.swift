//
//  _0211205_DavidMathisen_NYCSchoolsTests.swift
//  20211205-DavidMathisen-NYCSchoolsTests
//
//  Created by user207826 on 12/5/21.
//

import XCTest
@testable import _0211205_DavidMathisen_NYCSchools

class _0211205_DavidMathisen_NYCSchoolsTests: XCTestCase {
    func testAPISchoolSATCallGoodDbn() throws {
        let apiService: APIService = APIService()
        
        //given
        let dbn = "02M630"
        var schooolSATData: SchoolSATData!
        
        let expectation = XCTestExpectation(description: #function)
        
        //when
        apiService.apiGetSchoolSATData(dbn: dbn) { (schoolSATData) in
            schooolSATData = schoolSATData
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
                
        //then
        XCTAssertNotEqual(schooolSATData.mathAvgScoreString, "Unavailable")
    }
    
    func testAPISchoolSATCallBadDbn() throws {
        let apiService: APIService = APIService()
        
        //given
        let dbn = "BADDBN"
        var schooolSATData: SchoolSATData!
        
        let expectation = XCTestExpectation(description: #function)
        
        //when
        apiService.apiGetSchoolSATData(dbn: dbn) { (schoolSATData) in
            schooolSATData = schoolSATData
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
                
        //then
        XCTAssertEqual(schooolSATData.mathAvgScoreString, "Unavailable")
    }
}
