//
//  ViewController.swift
//  DemoForInterview
//
//  Created by kkmm on 2020/3/1.
//  Copyright © 2020 kkmm. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate	 {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.setUI();
	}
	func setUI() {
		let tv = UITableView(frame: view.bounds, style: .plain)
		view.addSubview(tv)
		tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
		tv.dataSource = self;
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
		cell.textLabel?.text = "hello ~~~ \(indexPath.row)"
		return cell
		
	}
}

