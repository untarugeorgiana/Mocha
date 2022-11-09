//
//  AlertsCell.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 30.10.2022.
//


import Foundation
import UIKit

class AlertsCell: UITableViewCell{
	
	@IBOutlet weak var source: UILabel!
	@IBOutlet weak var endDate: UILabel!
	@IBOutlet weak var startDate: UILabel!
	@IBOutlet weak var eventName: UILabel!
	@IBOutlet weak var picture: UIImageView!
	
	var alertData: Features = Features(properties: Properties(affectedZones: [])){
		didSet{
			source.text = alertData.id ?? ""
			endDate.text = alertData.properties.ends ?? ""
			startDate.text = alertData.properties.effective ?? ""
			eventName.text = alertData.properties.headline ?? ""
			picture.backgroundColor = .red
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func prepareForReuse() {
		source.text = ""
		endDate.text = ""
		startDate.text = ""
		eventName.text = ""
		picture.backgroundColor = .red
	}
	
}
