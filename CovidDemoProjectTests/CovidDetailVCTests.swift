//
//  CovidDetailVCTests.swift
//  CovidDemoProjectTests
//
//  Created by Amit Gupta on 18/03/24.
//

import XCTest
@testable import CovidDemoProject

final class CovidDetailVCTests: XCTestCase {
    
    private var sut: CovidDetailViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            identifier: String(describing: CovidDetailViewController.self))
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_outletsText_should_Conected() {
        XCTAssertNotNil(sut.lblConfirmCases, "Confirm Cases")
        XCTAssertNotNil(sut.lblDeathCases, "Dealth Cases")
        XCTAssertNotNil(sut.lblLastUpdate, "LastUpdate")
    }
    
    func setMockingData() {
        // Mocking data
        sut.covidDetail = CovidDataList(provinceState: "Delhi", countryRegion: "India", lastUpdate: "18-03-24 2:20:30", lat: "34.34356", long: "54.45456", confirmed: "4345", deaths: "34", recovered: "45", active: "76")
    }
    
    func test_outletsText_shouldBeNotNil() {
        setMockingData()
        sut.lblConfirmCases.text = sut.covidDetail?.confirmed
        sut.lblDeathCases.text = sut.covidDetail?.deaths
        sut.lblLastUpdate.text = sut.covidDetail?.lastUpdate
        
        XCTAssertEqual(sut.lblConfirmCases.text, "4345")
        XCTAssertEqual(sut.lblDeathCases.text, "34")
        XCTAssertEqual(sut.lblLastUpdate.text, "18-03-24 2:20:30")
    }
}
