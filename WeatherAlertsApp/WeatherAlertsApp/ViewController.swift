//
//  ViewController.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 30.10.2022.
//

import UIKit

var cache = NSCache<AnyObject,AnyObject>()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var weatherAlerts: WeatherAlertsInfo = WeatherAlertsInfo(features: []) {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		fetchData(url: URL(string: "https://api.weather.gov/alerts/active?status=actual&message_type=alert")!)
	}
	
	//IBOutlets
	
	@IBOutlet weak var tableView: UITableView!
	
	func fetchData(url:URL) {		
		let task = URLSession.shared.dataTask(with: url) {[self] data, response, error in
			if let data = data {
				do {
					let decoder = JSONDecoder()
					let decodedData = try decoder.decode(WeatherAlertsInfo.self, from: data)
					print(decodedData)
					weatherAlerts = decodedData
					
				} catch let err {
					print("Err", err)
				}
			} else if let error = error {
				print("HTTP Request Failed \(error)")
			}
		}
		
		task.resume()
		
	}
	
	func getAffectedAreas(alertInfo:Features, completion: @escaping ([String]?) -> Void) {
		var zones:[String] = []
			for zone in alertInfo.properties.affectedZones{
				if let zone = zone
				{
					let task = URLSession.shared.dataTask(with: URL(string:zone)!) {data, response, error in
						if let data = data {
							do {
								let decoder = JSONDecoder()
								let decodedData = try decoder.decode(Zones.self, from: data)
								zones.append(decodedData.properties.name ?? "")
								completion(zones)

							} catch let err {
								print("Err", err)
							}
						} else if let error = error {
							print("HTTP Request Failed \(error)")
						}
					}
					
					task.resume()
				}
			
		}
	}
	
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weatherAlerts.features.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let alert = weatherAlerts.features[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "AlertsCell", for: indexPath) as? AlertsCell
		cell?.alertData = alert
		cell?.picture.load(id:weatherAlerts.features[indexPath.row].id ?? "", cache: cache)
		return cell!
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard self.weatherAlerts.features.count>0 else {
			return
		}
		let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
		viewController.alertInfo = self.weatherAlerts.features[indexPath.row]
		getAffectedAreas(alertInfo: self.weatherAlerts.features[indexPath.row]) { zones in
			if let zones = zones{
				viewController.zones = zones
			}
		}
		self.present(viewController, animated: true, completion: nil)
		
	}
	
	
}

extension UIImageView {
	func load(id: String, cache: NSCache<AnyObject,AnyObject>){
		if let image = cache.object(forKey: id as NSString) as? UIImage{
			self.image = image as UIImage
			return
		}
		
		let url = URL(string: "https://picsum.photos/1000")!
		DispatchQueue.global().async {[weak self] in
			if let data = try? Data(contentsOf: url){
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						cache.setObject(image, forKey: id as NSString)
						self?.image = image
					}
				}
			}
		}
	}
}

