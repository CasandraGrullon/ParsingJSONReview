//: [Previous](@previous)

import Foundation

let json = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    }
]
""".data(using: .utf8)!

struct City: Decodable {
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

do {
    let results = try JSONDecoder().decode([City].self, from: json)
    dump(results)
} catch {
    print("decoding error: \(error.localizedDescription)")
}


