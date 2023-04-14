//
//  test.swift
//  SceneApp3
//
//  Created by Jason Lott on 4/14/23.
//

import UIKit

class test: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        
        // Do any additional setup after loading the view.
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

extension test: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else { return }
      print(text)
  }
}
