//
//  ViewController.swift
//  WINK app
//
//  Created by Francesco Fuscaldo on 01/08/18.
//  Copyright © 2018 Francesco Fuscaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SendNameDelegate {

    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseButton.layer.cornerRadius = 8
        chooseButton.layer.borderWidth = 1
        chooseButton.layer.borderColor = UIColor.darkGray.cgColor
        
        nameLabel.layer.cornerRadius = 8
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.darkGray.cgColor
        nameLabel.text = "My name is"
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseNameAction(_ sender: Any) {
        performSegue(withIdentifier: "chooseNameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseNameSegue" {
            let controller = segue.destination as! SecondViewController
            controller.sendName = self
        }
    }
    
    func passString(string: String) {
        self.navigationController?.popViewController(animated: true)
        nameLabel.text = "My name is " + string
    }

}

