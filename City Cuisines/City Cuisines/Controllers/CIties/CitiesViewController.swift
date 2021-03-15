//
//  CitiesViewController.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 19/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    //Outlets
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var searchBarForCities: UISearchBar!
    @IBOutlet weak var citiesSpinner: UIActivityIndicatorView!
    
    //Variables And Constants
    var citiesArray: [LocationSuggestionsModel]?
    var mainCitiesArray: [LocationSuggestionsModel]?
    let objCitiesDataHelper = CitiesDataHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting tableview datasource and delegate methods
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        searchBarForCities.delegate = self
        
        citiesTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Get Cities Data
        getCitiesData()
    }
    
    func getCitiesData() {
        // Show activity indicator
         actionOnActivityIndicator(shouldHide: false)
        objCitiesDataHelper.getCitiesData { (citiesModel, error) in
            if error != nil {
                self.actionOnActivityIndicator(shouldHide: true)
                self.showAlertWithMessage()
            } else {
                self.citiesArray = citiesModel?.locationSuggestions
                if (self.citiesArray?.count) != nil {
                    self.mainCitiesArray = self.citiesArray
                    self.actionOnActivityIndicator(shouldHide: true)
                    self.citiesTableView.reloadData()
                }
            }
        }
    }
    
    func actionOnActivityIndicator(shouldHide: Bool) {
        if(shouldHide) {
            citiesSpinner.isHidden = true
            citiesSpinner.stopAnimating()
        }else {
            citiesSpinner.isHidden = true
            citiesSpinner.startAnimating()
        }
    }
    
    func showAlertWithMessage(alertMessage: String = COMMON_MESSAGE) {
        let alert = UIAlertController(title: " ", message:alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CuisinesViewController
        if let indexPath = citiesTableView.indexPathForSelectedRow {
            destinationVC.cityID = citiesArray?[indexPath.row].id ?? 0
        }
    }
}

extension CitiesViewController:UITableViewDataSource, UITableViewDelegate {
    //MARK: TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell", for: indexPath)
        cityCell.textLabel?.text = citiesArray?[indexPath.row].name
        cityCell.accessoryType = .disclosureIndicator
        return cityCell
    }
    
    //MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // To get a touch effect
        performSegue(withIdentifier: "GoToCuisinesVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true )
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        citiesArray = citiesArray?.filter({($0.name?.localizedCaseInsensitiveContains(searchBar.text!))!})
        if citiesArray?.count == 0 {
            showAlertWithMessage(alertMessage: MSG_NOT_FOUNT)
        } else {
            citiesTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesArray = mainCitiesArray
        citiesTableView.reloadData()
    }
}


