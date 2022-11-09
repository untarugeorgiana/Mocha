//
//  ViewController.swift
//  jkbhgvf
//
//  Created by Georgiana.Untaru on 30.10.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var label: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let quote = "@My Very First Commit@ $by GeorgianaU$ #s. f.# (#Med.#) This fixes most important bugs #2022-10-28# @Weather App@"
		let attributesForBold: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.white,
			.backgroundColor: UIColor.red,
			.font: UIFont.boldSystemFont(ofSize: 36)
		]
		let attributesForItalic: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.white,
			.backgroundColor: UIColor.red,
			.font: UIFont.italicSystemFont(ofSize: 36)
		]
		
		let mutableAttributedString = NSMutableAttributedString(string: quote)
		if let matches = try? regexMatches("(?<=@)[^@]+", string: quote) {
			let last = matches.count
			for match in stride(from: 0, to: last, by: 2){
				mutableAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: matches[match].range)
			}
		}
		if let matches2 = try? regexMatches("(?<=\\$)[^\\$]+", string: quote) {
			let last = matches2.count
			for match in stride(from: 0, to: last, by: 2){
				mutableAttributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 16), range: matches2[match].range)
			}
		}
		if let matches3 = try? regexMatches("(?<=#)[^#]+", string: quote) {
			let last = matches3.count
			for match in stride(from: 0, to: last, by: 2){
				mutableAttributedString.deleteCharacters(in: matches3[match].range)
			}
		}
		
		
		label.attributedText=mutableAttributedString
		
	
		
		
	}

	func regexMatches(_ pattern: String, string: String) throws -> [NSTextCheckingResult]? {
		let regex = try NSRegularExpression(pattern: pattern)
		let range = NSRange(string.startIndex..<string.endIndex, in: string)
		return regex.matches(in: string, options: [], range: range)
	}
}


