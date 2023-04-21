//
//  ExploreTabViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 12/1/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ExploreTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    


    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateSelection: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var filteredEvents: [AppDelegate.Event] = []
    var events: [AppDelegate.Event] = []
    
    
    let search = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
      return search.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return search.isActive && !isSearchBarEmpty
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        appDelegate.refreshEvents()
        events = appDelegate.events


        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        search.searchBar.scopeButtonTitles = ["All", "Events", "Artists", "Venues"]
        navigationItem.searchController = search

        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event: AppDelegate.Event
      if isFiltering {
        event = filteredEvents[indexPath.row]
      } else {
        event = events[indexPath.row]
      }
      cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = DateFormatter().string(from: Date(timeIntervalSince1970: TimeInterval(integerLiteral: event.date.seconds)))
      return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedEvent: String = filteredEvents[indexPath.row]
//        performSegue(withIdentifier: "exploreEventSelect", sender: self)
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
      if isFiltering {
        return filteredEvents.count
      }
        
      return events.count
    }

    func filterContentForSearchText(_ searchText: String, type: Int) {
        filteredEvents = events.filter { (event: AppDelegate.Event) -> Bool in
        return event.name.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExploreTabViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      if !searchController.isActive {
          tableView.isHidden = true
          scrollView.isHidden = false
      } else {
          tableView.isHidden = false
          scrollView.isHidden = true
          let searchBar = searchController.searchBar
          filterContentForSearchText(searchBar.text!, type: 0)
      }
  }
}
extension ExploreTabViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, type: selectedScope)
  }
}

