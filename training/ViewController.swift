//
//  ViewController.swift
//  training
//
//  Created by P090MMCTSE010 on 12/10/23.
//

import UIKit

class ViewController: UIViewController{
    @IBAction func closeBioBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBOutlet weak var ReadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

