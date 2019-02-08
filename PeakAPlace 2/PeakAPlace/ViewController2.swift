//
//  ViewController2.swift
//  PeakAPlace
//
//  Created by Ana Boyer on 11/23/18.
//  Copyright © 2018 Ana Boyer. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
   
    @IBOutlet weak var addButton: UIButton!
   
    @IBAction func showAddPopUp(_ sender: Any) {
    
    let popOverAdd = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "AddVC") as! AddViewController
        self.addChildViewController(popOverAdd)
        popOverAdd.view.frame = self.view.frame
        self.view.addSubview(popOverAdd.view)
        popOverAdd.didMove(toParentViewController: self)
    }
    
    @IBOutlet weak var videoTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func setupVideoTable() {
        videoTable.dataSource = self
        videoTable.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelVideoCell") as! HotelVideoCell
        self.videoTable.rowHeight = 150
        let videoImage = UIImage(named:"Dog")!
        let hotelDescription = "This is the hotel video description"
        
        cell.setTable(image: videoImage, text:hotelDescription)
        
        return cell
        
    }
    

    override func viewDidLoad() {
        self.setupVideoTable()
        super.viewDidLoad()

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
