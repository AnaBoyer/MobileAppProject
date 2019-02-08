//
//  ViewController.swift
//  PeakAPlace
//
//  Created by Ana Boyer on 11/23/18.
//  Copyright © 2018 Ana Boyer. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var keyword = ""
    var theData:[Info] = []
    var theImageCache: [UIImage] = []
    
 
   let locationManager = CLLocationManager()
    
    @IBOutlet weak var hotelSearch: UITextField!
    
   
    @IBAction func keyEntered(_ sender: Any) {
    
    let text: String = hotelSearch.text!
        if (hotelSearch.text?.count)! > 0 {
            keyword = text
        }
        print(text)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyword = hotelSearch.text!
        searchHotels(hotelSearch)
        return true
    }
    
    func searchHotels(_ sender: Any) {
        self.activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
        setupTableView()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataForTableView()
            self.theImageCache = []
            self.cacheImages()
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    var indicator = UIActivityIndicatorView()
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }

    
    @IBOutlet weak var selectCityButton: UIButton!
    
    @IBAction func showCitySelector(_ sender: Any) {
    let popOverVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "citySelection") as! citySelectionViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
  
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        // 1
//        let nav = self.navigationController?.navigationBar
        
        // 2
//        nav?.barStyle = UIBarStyle.black
//        nav?.backgroundColor = UIColor(red: 255/255, green: 151/255, blue: 31/255, alpha: 1)
//        nav?.barTintColor = UIColor(red: 255/255, green: 151/255, blue: 31/255, alpha: 1)
//        nav?.tintColor = UIColor(red: 255/255, green: 151/255, blue: 31/255, alpha: 1.0)
        
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        imageView.contentMode = .scaleAspectFit
        
        // 4
        let image = UIImage(named: "Logo")
        imageView.image = image
        
        // 5
        navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        hotelSearch.delegate = self
        
        self.activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
        self.setupTableView()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataForTableView()
            self.cacheImages()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func fetchDataForTableView() {
        let url = URL(string:"https://research.engineering.wustl.edu/~todd/studio.json")
        let data = try! Data(contentsOf: url!)
        theData = try! JSONDecoder().decode([Info].self, from: data)
        print("the data is \(theData)")
        
    }
    
    func cacheImages() {
        
        for item in theData {
            let url = URL(string: item.image_url)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            theImageCache.append(image!)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell") as! hotelTableViewCell
        self.tableView.rowHeight = 100
        print("tableView_")
        print(theData)
        print("getting to cell")
        let hotelName = theData[indexPath.row].name
        print("finished hotelName")
        let hotelImage = theImageCache[indexPath.row]
        
        let hotelLocation = theData[indexPath.row].description
        cell.setHotel(theImage: hotelImage, theName: hotelName, theLocation: hotelLocation)
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("finding location")
        let someLocation = locations[0]
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\A single location is \(someLocation)")
        let howRecent = someLocation.timestamp.timeIntervalSinceNow
        locationManager.stopUpdatingLocation()
        
        if (howRecent < -10) {return}
        let accuracy = someLocation.horizontalAccuracy
        print("How recent is it? It is \(howRecent) with accuracy of \(accuracy) meters")
        locationManager.stopUpdatingLocation()
    }
    
    
}


