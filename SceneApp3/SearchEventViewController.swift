//
//  SearchEventViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 2/10/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SearchEventViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
    //    "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
     //   "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
      //  "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
       // "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var filteredData: [String]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        filteredData = appDelegate.eventNames
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? appDelegate.eventNames : appDelegate.eventNames?.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }

}
