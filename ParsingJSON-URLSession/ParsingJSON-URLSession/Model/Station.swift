//
//  Station.swift
//  ParsingJSON-URLSession
//
//  Created by casandra grullon on 8/4/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct DataWrapper: Decodable {
    let data: StationsData
}
struct StationsData: Decodable {
    let stations: [Station]
}
struct Station: Decodable, Hashable {
    let stationType: String
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stationType = "station_type"
        case latitude = "lat"
        case longitude = "lon"
        case capacity
    }
}
