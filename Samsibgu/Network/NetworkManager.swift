//
//  NetworkManager.swift
//  Samsibgu
//
//  Created by 장기화 on 2022/05/04.
//

import Foundation
import Alamofire

class NetworkManager {
    func fetchLocationSearch(keyword: String) async -> Result<[LocationSearchResponse], AFError> {
        let url = "https://www.metaweather.com/api/location/search/?query=\(keyword)"
        
        let data = await AF.request(url, method: .get)
            .serializingDecodable([LocationSearchResponse].self).result
        return data
    }
    
    func fetchLocation(woeid: String) async -> Result<LocationResponse, AFError> {
        let url = "https://www.metaweather.com/api/location/\(woeid)/"
        
        let data = await AF.request(url, method: .get)
            .serializingDecodable(LocationResponse.self).result
        return data
    }
}
