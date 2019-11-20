//
//  ViewController.swift
//  Rush Captain
//
//  Created by Ryan Cobelli on 11/20/19.
//  Copyright © 2019 rybel-llc. All rights reserved.
//

import UIKit

struct Brother {
	var name: String
	var cycled: Bool = false
	var time: Int = 0
}

class ViewController: UITableViewController {
	
	var numRows = 0
	var brothers : [Brother] = [Brother]()
	var timer = Timer()
	var selectedRow : IndexPath?
	var editingNow : Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
        
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
			for i in 0..<self.brothers.count {
				self.brothers[i].time += 1
			}
			if !self.editingNow {
				self.tableView.reloadData()
			}
		})
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedRow = indexPath
		increaseRows(sender: tableView)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return brothers.count
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "timer", for: indexPath) as! TimerTableViewCell
		
		cell.brotherName = brothers[indexPath.row].name
		cell.timeElapsed = brothers[indexPath.row].time
		cell.status = brothers[indexPath.row].cycled ? .pendingCycle : .active

		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
		editingNow = true
	}
	
	override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
		editingNow = false
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			brothers.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .left)
		}
	}
	
	@IBAction func increaseRows(sender: Any) {
		let alert = UIAlertController(title: "Add New Brother", message: "Please enter the brothers name", preferredStyle: .alert)

		alert.addTextField { (textField) in
			textField.placeholder = "Mike Hunt"
			textField.autocapitalizationType = .words
			textField.returnKeyType = .done
		}

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let textField = alert?.textFields![0]
			
			if self.selectedRow != nil {
				self.brothers[self.selectedRow!.row].cycled = true
				self.brothers[self.selectedRow!.row].name += " (by " + textField!.text! + ")"
				
				self.selectedRow = nil
			}
			
			self.brothers.append(Brother(name: textField!.text!))
		}))
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
			self.selectedRow = nil
		}))

		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func setTime(sender: Any) {
		let alert = UIAlertController(title: "Set Cycle Time Goal", message: "What is the goal for cycling people off? (seconds)", preferredStyle: .alert)

		alert.addTextField { (textField) in
			textField.placeholder = "10"
			textField.keyboardType = .numberPad
			textField.returnKeyType = .done
			textField.text = UserDefaults.standard.string(forKey: "goalTime")
		}

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let textField = alert?.textFields![0]
			
			UserDefaults.standard.set(Int((textField?.text!)!), forKey: "goalTime")
		}))
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
			self.selectedRow = nil
		}))

		self.present(alert, animated: true, completion: nil)
	}

}

