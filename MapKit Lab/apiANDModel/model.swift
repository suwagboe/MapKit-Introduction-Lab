//
//  model.swift
//  MapKit Introduction Lab
//
//  Created by Pursuit on 2/24/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation

struct SchoolData: Codable{
    let schoolName: String
    let borough: String
    let zip: Int
    let latitude: Double
    let longitude: Double
    let website: String
    
    private enum CodingKeys: String, Codable, CodingKey {
      case schoolName = "school_name"
      case latitude, longitude, borough, zip, website
    }
}

struct PublicSchoolData: Codable {
    
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>
/*
 struct NYCPublicSchool: Codable {
   let schools: [School]
 }
 struct School: Codable {
   let schoolName: String
   let location: String
   let latitude: String
   let longitude: String
   private enum CodingKeys: String, Codable, CodingKey {
     case schoolName = "school_name"
     case location
     case latitude
     case longitude
   }
 }
 */

