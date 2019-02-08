//
//  citySelectionViewController.swift
//  PeakAPlace
//
//  Created by Ana Boyer on 11/23/18.
//  Copyright © 2018 Ana Boyer. All rights reserved.
//

import UIKit

class citySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCities.count
//        return citiesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("-------------------Updating Table View------------------")
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
//        print(searchCities[0].city)
        if citySearchField.text?.count != 0{
//            print("text count greater than 0")
            
//            print(searchCities)
        }
//        print("searchCities")
//        print(searchCities)
//        cell?.textLabel!.text = citiesList[indexPath.row]
        cell?.textLabel!.text = searchCities[indexPath.row].city
        cell?.detailTextLabel?.text = searchCities[indexPath.row].state
        return cell!
    }
    

    
    func setupTableView() {
        cityTable.dataSource = self
        cityTable.delegate = self
        cityTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    
    @IBOutlet weak var citySearchField: UITextField!
    @IBOutlet weak var cityTable: UITableView!
    
    var cities:[Cities] = []
     var searchCities:[Cities] = []

    
    func parseCities() {

        let url = Bundle.main.url(forResource:"fixedCities", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)

        cities = try! JSONDecoder().decode([Cities].self, from: jsonData)
        searchCities = cities
        print("marker1" + String(searchCities.count))
        self.cityTable.reloadData()
    }

    var selectedCity = ""
    var citiesList: [String] = [String]()
    var originalCitiesList: [String] = [String]()

    
    
    override func viewDidLoad() {
        
        parseCities()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
      
        for city in cities {
            originalCitiesList.append(city.city)
            citiesList.append(city.city)
//            print("originalCitiesList")
//            print(originalCitiesList)
            
        }
        cityTable.delegate = self
        cityTable.dataSource = self
        citySearchField.delegate = self
        citySearchField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citySearchField.resignFirstResponder()
        return true
    }
    
    @objc func searchRecords(_ textField: UITextField) {
       
         self.citiesList.removeAll()
        if citySearchField.text?.count != 0 {
            self.searchCities.removeAll()
            for city in originalCitiesList {
                if let cityToSearch = citySearchField.text{
                        let range = city.lowercased().range(of: cityToSearch, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.citiesList.append(city)
                            
                        }
                    }
                
            }
        }else{
            for city in originalCitiesList {
                citiesList.append(city)
            }

        }
        for city in cities {
            for item in citiesList {
                //                var i = 0
                //                while i < cities.count {
                //                    let b = cities[i].city.contains(item)
                //
                //                if b == true {
                //                    searchCities.append(cities[i])
                //                }
                //            print(b)
                //                    i+=1
                if city.city == item {
                    searchCities.append(city)
                }
            }
        }
        print("------------------Reloading Data--------------------")
        cityTable.reloadData()
       
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.removeFromSuperview()
       
        let selectedCity = cities[indexPath.row].city
//        selectedCity = cities[indexPath.row].city
        let selectedCityState = cities[indexPath.row].state
        print("selectedCity")
        print(selectedCity + ", " + selectedCityState)
       
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

