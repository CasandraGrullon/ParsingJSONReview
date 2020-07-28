//: [Previous](@previous)

import Foundation

//Parsing Dictionary

var json = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Alex",
    "lastName": "Paul"
  }
 ]
}
""".data(using: .utf8)!

struct ResultsWrapper: Decodable {
    let results: [Contact]
}
struct Contact: Decodable {
    let firstName: String
    let lastName: String
}

do {
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
    let contacts = dictionary.results
    dump(contacts)
} catch {
    print("decoding error: \(error.localizedDescription)")
}

