//
//  CountryListViewModel.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import Alamofire
import Foundation

class CovidListViewModel {
    // MARK: - Properties
    
    var apiClient: APIClientProtocol
    var dataSource: GenericDataSource<CovidDataList>?
    var onError: ((String) -> ())?
    var setupLoader: ((Bool) -> ())?
    
    /// Property with didSet to notify activity loader hide show
    
    var showLoader: Bool = false {
        didSet {
            setupLoader?(showLoader)
        }
    }
    
    /// Property with didSet to notify error message on network response failure
    
    var errorMessage: String = "" {
        didSet {
            onError?(errorMessage)
        }
    }
    
    // MARK: - Initializer
    
    init(apiClient: APIClientProtocol = APIClient(), dataSource: GenericDataSource<CovidDataList>?) {
        self.apiClient = apiClient
        self.dataSource = dataSource
    }
}

// MARK: - Extension

/// Conformation class for covid list web service protocol
/// Will fetch list of covid cases and update datasource on response

extension CovidListViewModel: CovidListViewContract {
    
    func fetchCovidList() {
        let request = APIRouter.covidList
        
        showLoader = true
        apiClient.performRequest(route: request) { [weak self](response: DataResponse<CovidDataModel>) in
            self?.showLoader = false
            
            if let error = response.error{
                self?.errorMessage = error.localizedDescription
            }else if let response = response.result.value{
                self?.dataSource?.data.value = response.covidDataList ?? []
            }else{
                self?.errorMessage = APIError.requestError.rawValue
            }
        }
    }
}

protocol CovidListViewContract {
    func fetchCovidList()
}

protocol CovidListAPIProtocol {
    typealias completionHandler = (Result<CovidDataModel, APIError>) -> ()
    func fetchVehiclesList()
}
