//
//  TimerTableViewCell.swift
//  Rush Captain
//
//  Created by Ryan Cobelli on 11/20/19.
//  Copyright © 2019 rybel-llc. All rights reserved.
//

import UIKit

enum BrotherStatus {
	case active
	case pendingCycle
}

class TimerTableViewCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel?
	@IBOutlet weak var timerLabel: UILabel?
	
	public var brotherName : String? {
		didSet {
			nameLabel?.text = brotherName
		}
	}
	public var status : BrotherStatus = .active
	
	public var timeElapsed : Int = 0 {
		didSet {
			timerLabel?.text = String(format:"%02d:%02d", (timeElapsed / 60), (timeElapsed % 60))
			
			if (status == .active) {
				let goalTime = UserDefaults.standard.integer(forKey: "goalTime")
				
				var tmpBG : UIColor?
				
				switch Int((Float(self.timeElapsed) / Float(goalTime)) * 10) {
				case 0:
					tmpBG = UIColor(red: 1.000, green: 0.984, blue: 0.835, alpha: 1.00)
					break
				case 1:
					tmpBG = UIColor(red: 0.965, green: 0.878, blue: 0.761, alpha: 1.00)
					break
				case 2:
					tmpBG = UIColor(red: 0.929, green: 0.773, blue: 0.686, alpha: 1.00)
					break
				case 3:
					tmpBG = UIColor(red: 0.898, green: 0.667, blue: 0.612, alpha: 1.00)
					break
				case 4:
					tmpBG = UIColor(red: 0.800, green: 0.561, blue: 0.537, alpha: 1.00)
					break
				case 5:
					tmpBG = UIColor(red: 0.863, green: 0.561, blue: 0.537, alpha: 1.00)
					break
				case 6:
					tmpBG = UIColor(red: 0.831, green: 0.459, blue: 0.467, alpha: 1.00)
					break
				case 7:
					tmpBG = UIColor(red: 0.784, green: 0.353, blue: 0.392, alpha: 1.00)
					break
				case 8:
					tmpBG = UIColor(red: 0.765, green: 0.247, blue: 0.318, alpha: 1.00)
					break
				case 9:
					tmpBG = UIColor(red: 0.729, green: 0.141, blue: 0.243, alpha: 1.00)
					break
				default:
					tmpBG = UIColor(red: 0.698, green: 0.039, blue: 0.173, alpha: 1.00)
				}
				
				if tmpBG != self.backgroundColor {
//					UIView.animate(withDuration: 1, animations: { () -> Void in
						self.backgroundColor = tmpBG
//					})
				}
				nameLabel?.textColor = UIColor.black
				timerLabel?.textColor = UIColor.black
			} else {
				backgroundColor = UIColor(red: 0.345, green: 0.498, blue: 0.659, alpha: 1.00)
				nameLabel?.textColor = UIColor.white
				timerLabel?.textColor = UIColor.white
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = UIColor(red: 1.000, green: 0.984, blue: 0.835, alpha: 1.00)
	}
}
