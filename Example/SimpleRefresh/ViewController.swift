//
//  ViewController.swift
//  SimpleRefresh
//
//  Created by qiuncheng on 02/28/2019.
//  Copyright (c) 2019 qiuncheng. All rights reserved.
//

import UIKit
import SimpleRefresh

class ViewController: UITableViewController {

    var array = ["Objc", "Swift", "Kotlin", "PHP", "Ruby", "Java", "JavaScript", "golang", "Rust", "Objc", "Swift", "Kotlin", "PHP", "Ruby", "Java", "JavaScript", "golang", "Rust", "Objc", "Swift", "Kotlin", "PHP", "Ruby", "Java", "JavaScript", "golang", "Rust", ]
    let array2 = ["Objc", "Swift", "Kotlin", "PHP", "Ruby", "Java", "JavaScript", "golang", "Rust"]
    
    var colors: [String: UIColor] = [
        "Objc": .red,
        "Swift": .magenta,
        "Kotlin": .green,
        "PHP": .darkGray,
        "Ruby": .cyan,
        "Java": .brown,
        "JavaScript": .yellow,
        "golang": .orange,
        "Rust": .blue
    ]
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
//        tableView.tz.addHeader(ChatHeader())
//        tableView.tz.addHeaderTarget(self, selector: #selector(handleHeaderRefresh))
        tableView.smp.addHeader(NormalHeaderAnimation(), target: self, action: #selector(handleHeaderRefresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.scrollToRow(at: IndexPath(row: array.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc private func handleHeaderRefresh() {
        title = "刷新中"
        count += 1
        let otherRandom = Int(arc4random_uniform(UInt32(100)))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let sSelf = self else { return }
            for _ in 0 ... otherRandom {
                let random = Int(arc4random_uniform(UInt32(sSelf.array2.count)))
                let temp = sSelf.array2[random]
                self?.array.append(temp) // insert(temp, at: 0)
            }
            self?.tableView.reloadData()
            self?.title = "刷新完毕"
            if sSelf.count > 5 {
                sSelf.tableView.smp.removeHeader()
                return
            }
            else {
                self?.tableView.smp.stopHeaderRefresh()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row] + " " + "\(indexPath.row)"
        let color = colors[array[indexPath.row]]
        cell.contentView.backgroundColor = color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        tableView.smp.startHeaderRefresh()
    }
}

