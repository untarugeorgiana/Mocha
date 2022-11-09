//
//  WeatherAlert.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 30.10.2022.
//

import Foundation

struct Properties: Codable{
	var effective: String?
	var ends: String?
	var headline: String?
	var severity: String?
	var certainty: String?
	var urgency: String?
	var sender: String?
	var description: String?
	var affectedZones:[String?]
	var instruction: String?
	
	enum CodingKeys: String, CodingKey{
		case effective
		case ends
		case headline
		case severity
		case certainty
		case urgency
		case sender
		case description
		case affectedZones
		case instruction
	}

}

struct Features: Codable{
	var id: String?
	var properties: Properties
	
	enum CodingKeys: String, CodingKey {
		case id
		case properties
	}

	
}

struct WeatherAlertsInfo: Codable{
	var features:[Features]
	
	enum CodingKeys: String, CodingKey {
		case features
	}
	
	
}
