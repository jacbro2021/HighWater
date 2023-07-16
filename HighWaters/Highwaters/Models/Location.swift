//
//  Location.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import Foundation

struct Location {
    let Latitude: Double
    let Longitude: Double
    
    func toDictionary() -> [String:Any] {
        return ["Latitude":Latitude, "Longitude":Longitude]
    }
}

extension Location {
    
    init?(dictionary: [String:Any]) {
        guard let latitude = dictionary["Latitude"] as? Double,
              let longitude = dictionary["Longitude"] as? Double else {
                  return nil
              }
        
        Latitude = latitude
        Longitude = longitude
    }
}
