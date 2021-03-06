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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    tableView.smp.addHeader(AmazingHeader(), target: self, action: #selector(handleHeaderRefresh))
    tableView.smp.addRefresh(forType: .header, animationView: AmazingHeader(), target: self, action: #selector(handleHeaderRefresh))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.smp.startRefresh(forType: .header)
  }
  
  @objc private func handleHeaderRefresh() {
    title = "刷新中"
    let otherRandom = Int.random(in: 10 ... 100)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
      guard let sSelf = self else { return }
      let arr = Array(0 ... otherRandom).map({ (value) -> String in
        let random = Int.random(in: 0 ..< sSelf.array2.count)
        return sSelf.array2[random]
      })
      sSelf.array = arr
      sSelf.tableView.reloadData()
      sSelf.title = "刷新完毕"
      
      if sSelf.tableView.smp.refreshControl(forType: .footer) == nil {
        sSelf.tableView.smp.addRefresh(forType: .footer, animationView: StateFooterAnimation(), target: sSelf, action: #selector(ViewController.handleFooterRefresh))
      }
      sSelf.tableView.smp.stopRefresh(forType: .header)
    }
  }
  
  @objc func handleFooterRefresh() {
    let otherRandom = Int.random(in: 5 ... 10)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
      guard let sSelf = self else { return }
      let arr = Array(0 ... otherRandom).map({ (value) -> String in
        let random = Int.random(in: 0 ..< sSelf.array2.count)
        return sSelf.array2[random]
      })
      sSelf.array.append(contentsOf: arr)
      sSelf.title = "刷新完毕"
      sSelf.tableView.reloadData()
      
      sSelf.tableView.smp.stopRefresh(forType: .footer)
      let stateView = sSelf.tableView.smp.animationView(forType: .footer) as? StateFooterAnimation
      stateView?.state = .noMoreData
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
    tableView.smp.startRefresh(forType: .header)
  }
}

