//
//  CuisinesViewController.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 20/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

class CuisinesViewController: UIViewController {

    //Outlets
    @IBOutlet weak var cuisinesTableView: UITableView!
    @IBOutlet weak var cuisineSpinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBarForCuisines: UISearchBar!
    
    //Constant and variables
    var objCuisinesArray: [CuisinesModel]?
    let objCuisinesDataHelper = CuisinesDataHelper()
    var cityID = 0
    var mainCuisineArray = [String]()
    var traversalCuisineArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Table view delegate and Datasoucrce
        cuisinesTableView.dataSource = self
        cuisinesTableView.delegate = self
        
        //search bar delegate
        searchBarForCuisines.delegate = self
        
        cuisinesTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //get the cuisine data for a city
        getCuisinesData()
        
    }
    
    func getCuisinesData() {

        //start activity indicator
        actionOnActivityIndicator(shouldHide: false)
        
        objCuisinesDataHelper.getCusinesData(for: cityID){ (cuisinesRootModel, error) in
            if error != nil {
                self.actionOnActivityIndicator(shouldHide: true)
                self.showAlertWithMessage()
            } else {
                self.objCuisinesArray = cuisinesRootModel?.cuisines
                if let count = self.objCuisinesArray?.count {
                    for index in 0..<count {
                        if let cuisine = self.objCuisinesArray?[index].cuisine {
                            let name = cuisine.cuisineName!
                            self.mainCuisineArray.append(name)
                        }
                    }
                    self.traversalCuisineArray = self.mainCuisineArray
                }
                // stop and hide activity indicator
                self.actionOnActivityIndicator(shouldHide: true)
                self.cuisinesTableView.reloadData()
            }
        }
    }
    
    func showAlertWithMessage(alertMessage: String = COMMON_MESSAGE) {
        let alert = UIAlertController(title: " ", message:alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func actionOnActivityIndicator(shouldHide: Bool) {
        if(shouldHide) {
            cuisineSpinner.isHidden = true
            cuisineSpinner.stopAnimating()
        }else {
            cuisineSpinner.isHidden = true
            cuisineSpinner.startAnimating()
        }
    }

}

extension CuisinesViewController:UITableViewDataSource, UITableViewDelegate {
    //MARK: TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return traversalCuisineArray.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cuisineCell = tableView.dequeueReusableCell(withIdentifier: "CuisineTableViewCell", for: indexPath)
        cuisineCell.textLabel?.text = traversalCuisineArray[indexPath.row]
        return cuisineCell
    }
    
    //MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
 
}

extension CuisinesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        traversalCuisineArray = traversalCuisineArray.filter({$0.localizedCaseInsensitiveContains(searchBar.text!)})
        if traversalCuisineArray.count == 0 {
            showAlertWithMessage(alertMessage: MSG_NOT_FOUNT)
        } else {
            cuisinesTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        traversalCuisineArray = mainCuisineArray
        cuisinesTableView.reloadData()
    }
}
