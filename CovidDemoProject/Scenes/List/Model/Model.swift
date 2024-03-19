//
//  Model.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import Foundation

// MARK: - CovidDataModel
struct CovidDataModel: Codable {
    var covidDataList: [CovidDataList]?
    
    enum CodingKeys: String, CodingKey {
        
        case covidDataList = "rawData"
    }
    
    init() {
    }
    
    init(covidDataList : [CovidDataList]) {
        self.covidDataList = covidDataList
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        covidDataList = try values.decodeIfPresent([CovidDataList].self, forKey: .covidDataList)
    }
}

// MARK: - CovidDataList
struct CovidDataList: Codable {
    
    var provinceState, countryRegion: String?
    var lastUpdate, lat, long, confirmed: String?
    var deaths, recovered, active: String?
    
    init(provinceState: String?, countryRegion: String?, lastUpdate: String?, lat: String?, long: String?, confirmed: String?, deaths: String?, recovered: String?, active: String?) {
        self.provinceState = provinceState
        self.countryRegion = countryRegion
        self.lastUpdate = lastUpdate
        self.lat = lat
        self.long = long
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
        self.active = active
    }
    enum CodingKeys: String, CodingKey {
        case provinceState = "Province_State"
        case countryRegion = "Country_Region"
        case lastUpdate = "Last_Update"
        case lat = "Lat"
        case long = "Long_"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        provinceState = try values.decodeIfPresent(String.self, forKey: .provinceState)
        countryRegion = try values.decodeIfPresent(String.self, forKey: .countryRegion)
        lastUpdate = try values.decodeIfPresent(String.self, forKey: .lastUpdate)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        confirmed = try values.decodeIfPresent(String.self, forKey: .confirmed)
        long = try values.decodeIfPresent(String.self, forKey: .long)
        deaths = try values.decodeIfPresent(String.self, forKey: .deaths)
        recovered = try values.decodeIfPresent(String.self, forKey: .recovered)
        active = try values.decodeIfPresent(String.self, forKey: .active)
    }
}


