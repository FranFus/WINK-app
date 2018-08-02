//
//  SecondViewController.swift
//  WINK app
//
//  Created by Francesco Fuscaldo on 01/08/18.
//  Copyright © 2018 Francesco Fuscaldo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var namesTableView: UITableView!
    var namesArray: Array<String> = []
    var label: String = ""
    var sendName: SendNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        self.namesTableView.register(nib, forCellReuseIdentifier: "tableViewCell")
        
        namesArray = ["Francesco", "Marco", "Luca", "Daenerys Stormborn of the House Targaryen, First of Her Name, the Unburnt, Queen of the Andals and the First Men, Khaleesi of the Great Grass Sea, Breaker of Chains, and Mother of Dragons", "Marco", "Luca", "John Snow"]
        namesTableView.delegate = self
        namesTableView.dataSource = self
        
        self.navigationItem.title = "Choose a name"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        
        cell?.cellLabel.text = self.namesArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
                namesArray.remove(at: indexPath.row)
    
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        label = self.namesArray[indexPath.row]
        sendName?.passString(string: label)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
