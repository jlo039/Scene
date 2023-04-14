//
//  SearchEventViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 2/10/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SearchEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static var selectedEvent: String = ""
    static var selectedEventID: String = ""
    
    var filteredData: [String]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        filteredData = Array(appDelegate.eventNames.keys)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var VCType: String = ""
        
        // Segue to the correct post type.
        switch (NewPostViewController.postType) {
        case 0:
            VCType = "PostPromotion"
            break
        case 1:
            VCType = "PostCheckIn"
            break
        case 2:
            VCType = "PostRecap"
            break
        default:
            print("FAIL")
        }
        
        SearchEventViewController.selectedEvent = filteredData[indexPath.row]
        print(SearchEventViewController.selectedEvent)
        SearchEventViewController.selectedEventID = appDelegate.eventNames[SearchEventViewController.selectedEvent]!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createPostController = storyboard.instantiateViewController(withIdentifier: VCType)
        self.navigationController?.pushViewController(createPostController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var names: [String]
        names = Array(appDelegate.eventNames.keys)
        
        filteredData = searchText.isEmpty ? names : names.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }   
        tableView.reloadData()
    }

}
