//
//  AlertsInfo.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 30.10.2022.
//

import Foundation

struct AlertsInfo: Decodable {
	
	var eventName: String
	var startDate: String
	var endDate: String
	var source: String
	
	enum RootKeys:String, CodingKey {
		case feature = "features"
		enum CodingKeys: String, CodingKey {
			case source = "id", properties = "properties"
			enum PropertiesKeys: String, CodingKey {
				case eventName = "headline", startDate = "effective", endDate = "ends"
			}
		}
	}
	
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: RootKeys.self)
		//id
		let idContainer = try container.nestedContainer(keyedBy: RootKeys.CodingKeys.self, forKey: .feature)
		self.source = try idContainer.decode(String.self, forKey: .source)
		
		let propertiesContainer = try container.nestedContainer(keyedBy: RootKeys.CodingKeys.self, forKey: .feature)
		// properties
		var propContainer = try propertiesContainer.nestedContainer(keyedBy: RootKeys.CodingKeys.PropertiesKeys.self, forKey: .properties)
		eventName = try propContainer.decode(String.self, forKey: .eventName)
		propContainer = try propertiesContainer.nestedContainer(keyedBy: RootKeys.CodingKeys.PropertiesKeys.self, forKey: .properties)
		startDate = try propContainer.decode(String.self, forKey: .startDate)
		propContainer = try propertiesContainer.nestedContainer(keyedBy: RootKeys.CodingKeys.PropertiesKeys.self, forKey: .properties)
		endDate = try propContainer.decode(String.self, forKey: .endDate)
		
		
	}
	
}
