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
    let urlString = "https://www.mocky.io/v2/5b62bfce30000049006500ea"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(retry))
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        self.namesTableView.register(nib, forCellReuseIdentifier: "tableViewCell")
        
        namesArray = []
        namesTableView.delegate = self
        namesTableView.dataSource = self
        
        self.navigationItem.title = "Choose a name"
        
        getNames()
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
    
    func getNames() {
        guard let url = NSURL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: (url as URL)) { (data, response, error) in
            if error != nil {
                self.namesArray.append("No item found, check the connection and retry")
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let array = json as? [Any] {
                
                for case let string as String in array {

                    if array.count > 0 {
                        self.namesArray.append(string)
                    } else {
                        self.namesArray.append("No item found")
                        
                    }
                }
            }
            
            //Get back to the main queue
            DispatchQueue.main.async {
                self.namesTableView?.reloadData()
            }
            
            
            }.resume()
        
        
    }
    
    @objc func retry() {
        namesArray = []
        getNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
