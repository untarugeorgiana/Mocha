//
//  Zones.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 04.11.2022.
//

import Foundation

struct ZonesProperties: Codable{
	var name: String?
	var radarStation: String?
	
	enum CodingKeys: String, CodingKey{
		case name
		case radarStation
	}

}

struct Zones: Codable{
	var id: String?
	var properties: ZonesProperties
	
	enum CodingKeys: String, CodingKey {
		case id
		case properties
	}

	
}

