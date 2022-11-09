//
//  DraggableImage.swift
//  WeatherAlertsApp
//
//  Created by Georgiana.Untaru on 02.11.2022.
//

import Foundation
import UIKit

class DraggableImage: UIImageView {

	var localTouchPosition : CGPoint?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.red.cgColor
		self.isUserInteractionEnabled = true
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch = touches.first
		self.localTouchPosition = touch?.preciseLocation(in: self)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesMoved(touches, with: event)
		let touch = touches.first
		guard let location = touch?.location(in: self.superview), let localTouchPosition = self.localTouchPosition else{
			return
		}
		self.frame.origin = CGPoint(x: location.x - localTouchPosition.x, y: location.y - localTouchPosition.y)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.localTouchPosition = nil
	}

}
