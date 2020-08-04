//
//  President.swift
//  ParsingJSONUsingBundle
//
//  Created by casandra grullon on 8/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct President: Decodable {
  let number: Int
  let name: String
  let birthYear: Int
  let deathYear: Int
  let tookOffice: String
  let leftOffice: String
  let party: String
  
  private enum CodingKeys: String, CodingKey {
    case number
    case name = "president"
    case birthYear = "birth_year"
    case deathYear = "death_year"
    case tookOffice = "took_office"
    case leftOffice = "left_office"
    case party
  }
}
