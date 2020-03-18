//
//  MemoryDemoListVC.swift
//  DemoForInterview
//
//  Created by kkmm on 2020/3/17.
//  Copyright © 2020 kkmm. All rights reserved.
//

import UIKit

class MemoryDemoListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataSource:Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "内存管理Demo列表"
        dataSource = ["指针，僵尸对象","堆，栈，内存布局，taggedPointer"]
        // Do any additional setup after loading the view.
        self.setUI()
    }
    func setUI() {
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.dataSource = self;
        table.delegate = self;
        self.view.addSubview(table)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "CellID")
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = MemoryManageVC();
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
           let vc = DemoForTaggerPointer();
           self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            fatalError("没有这个操作类型...")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
