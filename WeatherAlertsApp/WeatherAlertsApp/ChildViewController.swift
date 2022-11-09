//
//  ChildViewController.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 01.11.2022.
//

import Foundation
import UIKit

class ChildViewController: UIViewController{
	
	var alertInfo:Features?
	var zones:[String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		descriptions.numberOfLines = 2
		descriptions.lineBreakMode = .byWordWrapping
		descriptions.sizeToFit()
		descriptions.isUserInteractionEnabled = true
		instructions.numberOfLines = 2
		instructions.lineBreakMode = .byWordWrapping
		instructions.sizeToFit()
		instructions.isUserInteractionEnabled = true
		
		let tapDescription = UITapGestureRecognizer(target: self, action: #selector(ChildViewController.tapFunctionD))
		let tapInstructions = UITapGestureRecognizer(target: self, action: #selector(ChildViewController.tapFunctionI))
		descriptions.addGestureRecognizer(tapDescription)
		instructions.addGestureRecognizer(tapInstructions)
			
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if let alertInfo = alertInfo {
			DispatchQueue.main.async {
				self.period.text = "\(alertInfo.properties.effective ?? "No start date") - \(alertInfo.properties.ends ?? "No end date")"
				self.severity.text = alertInfo.properties.severity ?? "No information on severity"
				self.certainty.text = alertInfo.properties.certainty ?? "No information on certainty"
				self.urgency.text = alertInfo.properties.urgency ?? "No information on urgency"
				self.source.text = alertInfo.id
				self.descriptions.text = alertInfo.properties.description ?? "No description available"
				self.instructions.text = alertInfo.properties.instruction ?? "No instructions available"
				self.picture.load(id: alertInfo.id ?? "", cache: cache)
				let affectedAreasString = self.zones.joined(separator: ",")
				self.affectedAreas.text = affectedAreasString
			}
			
			
		}
	}
	
	//IBOutlets
	@IBOutlet weak var picture: UIImageView!
	@IBOutlet weak var period: UILabel!
	@IBOutlet weak var severity: UILabel!
	@IBOutlet weak var certainty: UILabel!
	@IBOutlet weak var urgency: UILabel!
	@IBOutlet weak var source: UILabel!
	@IBOutlet weak var descriptions: UILabel!
	@IBOutlet weak var instructions: UILabel!
	@IBOutlet weak var affectedAreas: UILabel!
	
	@IBAction func tapFunctionD(sender: UITapGestureRecognizer) {
		descriptions.numberOfLines = 0
		descriptions.sizeToFit()
		
	}
	@IBAction func tapFunctionI(sender: UITapGestureRecognizer) {
		instructions.numberOfLines = 0
		instructions.sizeToFit()
	}

}
