//
//  ViewController.swift
//  DemoForInterview
//
//  Created by kkmm on 2020/3/1.
//  Copyright © 2020 kkmm. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate	 {
    open var dataArray:Array<String>!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        dataArray = ["内存管理","其它"]
		// Do any additional setup after loading the view.
		self.setUI();
	}
	func setUI() {
		let tv = UITableView(frame: view.bounds, style: .plain)
		view.addSubview(tv)
		tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
		tv.dataSource = self;
        tv.delegate = self;
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
		cell.textLabel?.text = "\(dataArray[indexPath.row])"
		return cell
		
	}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataArray[indexPath.row] {
        case "内存管理":
            let vc = MemoryManageVC();
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            fatalError("没有这个操作类型...")
        }
    }
}

