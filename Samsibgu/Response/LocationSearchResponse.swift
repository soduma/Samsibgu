//
//  MetaWeatherAPI.swift
//  Samsibgu
//
//  Created by 장기화 on 2022/05/04.
//

import Foundation

struct LocationSearchResponse: Codable {
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}

struct LocationResponse: Codable {
    let consolidatedWeather: [ConsolidatedWeather]
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
    }
}

struct ConsolidatedWeather: Codable {
    let weatherStateName: String
    let weatherStateAbbr: String
    let temp: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case temp = "the_temp"
        case humidity
    }
}
