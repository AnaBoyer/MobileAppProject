//
//  AddViewController.swift
//  PeakAPlace
//
//  Created by Ana Boyer on 11/23/18.
//  Copyright © 2018 Ana Boyer. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    
    @IBOutlet weak var uploadVideoButton: UIButton!
    
    
    @IBOutlet weak var takeVideoButton: UIButton!
   
    @IBOutlet weak var cancelButton: UIButton!
   
    @IBAction func cancelUpload(_ sender: Any) {
    self.view.removeFromSuperview()
    }
    @IBOutlet weak var popupBackground: UIView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        super.viewDidLoad()
        self.view.layer.cornerRadius = 5;
        self.view.layer.masksToBounds = true;
        uploadVideoButton.layer.cornerRadius = 10;
        takeVideoButton.layer.cornerRadius = 10;
        cancelButton.layer.cornerRadius = 10;
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

