//
//  CovidDemoProjectTests.swift
//  CovidDemoProjectTests
//
//  Created by Amit Gupta on 17/03/24.
//

import XCTest
@testable import CovidDemoProject

import Alamofire
class CovidDemoProjectTests: XCTestCase {
    
    // MARK :-  Propertise
    
    var viewModel: CovidListViewModel!
    var vc: CountryListViewController!
    var dataSource: GenericDataSource<CovidDataList>!
    var mockApiClient: MockAPIClient!
    
    // Life cycle
    
    override func setUp() {
        super.setUp()
        
        // Initializing properties
        dataSource = GenericDataSource<CovidDataList>()
        viewModel = CovidListViewModel(dataSource: dataSource)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc =  storyboard.instantiateViewController(
            identifier: String(describing: CountryListViewController.self))
        mockApiClient = MockAPIClient()
        vc.loadViewIfNeeded()
    }
    
    // Life cycle
    
    override func tearDown() {
        
        // Deinitializing propertise
        viewModel = nil
        vc = nil
        dataSource = nil
        mockApiClient = nil
        
        super.tearDown()
    }
    
    /// METHOD to test if fetch vehicles list is working peoperly or not
    /// Expectation will catch a callback and listner would be called to update UI
    
    func testFetchCovidListWorking() {
        let expectation = XCTestExpectation(description: "covid List fetch")
        
        // giving a service mocking covid list
        mockApiClient.covideModel =  CovidDataModel(covidDataList: [CovidDataList(provinceState: "Delhi", countryRegion: "India", lastUpdate: "2024-03-15 04:21:04", lat: "23.3434444", long: "34.445353", confirmed: "23456", deaths: "456", recovered: "34", active: "65")])
        
        viewModel.onError = { _ in
            XCTAssert(false, "Failed to fetch Covid list")
        }
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchCovidList()
        wait(for: [expectation], timeout: 20.0)
    }
    
    /// test cases for checking tableview cell
    func test_Tableview() {
        
        let cell = vc.tableView.dequeue(CountryListTableViewCell.self, for:  IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        
        let vc = CovidDetailViewController.instantiate(fromAppStoryboard: .Main)
        XCTAssertNotNil(vc)
    }
    
    
    ///Test case for testing activity loader working
    /// expectation is will show and hide loading and functions are called properly
    
    func testActivityLoaderShowing() {
        let expectation = XCTestExpectation(description: "Covid List fetch")
        
        viewModel.setupLoader = {(loader) in
            if loader {
                expectation.fulfill()
            }else{
                expectation.fulfill()
            }
        }
        
        viewModel.fetchCovidList()
        wait(for: [expectation], timeout: 5.0)
    }
    
}

/// MOCK APIClient class for testing
/// Conforming APIClient protocol to call web service

class MockAPIClient: APIClientProtocol {
    
    var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadRevalidatingCacheData
        configuration.httpCookieStorage = nil
        
        var trustedPolicy: ServerTrustPolicyManager?
        let sessionManager = SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: trustedPolicy
        )
        
        return sessionManager
    }()
    
    var covideModel : CovidDataModel?
    
    func performRequest<T>(route: APIRouter, completionHandler: @escaping (DataResponse<T>) -> ()) where T : Decodable {
        
        sessionManager.request(route).responseObject { (response) in
            completionHandler(response)
        }
    }
}
