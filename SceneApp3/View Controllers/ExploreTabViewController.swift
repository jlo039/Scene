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
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        filteredData = appDelegate.eventNames
        tableView.dataSource = self
        tableView.delegate = self

        let image1:UIImage = UIImage(imageLiteralResourceName: "img-1")
        let image2:UIImage = UIImage(imageLiteralResourceName: "img-2")
        let image3:UIImage = UIImage(imageLiteralResourceName: "img-3")
        let image4:UIImage = UIImage(imageLiteralResourceName: "img-4")
        let image5:UIImage = UIImage(imageLiteralResourceName: "img-5")
        let image6:UIImage = UIImage(imageLiteralResourceName: "img-6")
        let image7:UIImage = UIImage(imageLiteralResourceName: "img-7")
        let image8:UIImage = UIImage(imageLiteralResourceName: "img-8")

        imageView1.image = image1
        imageView2.image = image2
        imageView3.image = image3
        imageView4.image = image4
        imageView5.image = image5
        imageView6.image = image6
        imageView7.image = image7
        imageView8.image = image8
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent: String = filteredData[indexPath.row]
        print(selectedEvent)

        performSegue(withIdentifier: "exploreEventSelect", sender: self)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
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
          guard let text = searchController.searchBar.text else { return }
          scrollView.isHidden = true
          tableView.isHidden = false
          filteredData = text.isEmpty ? appDelegate.eventNames : appDelegate.eventNames.filter { (item: String) -> Bool in
              // If dataItem matches the searchText, return true to include it
              return item.range(of: text, options: .caseInsensitive, range: nil, locale: nil) != nil
          }
          tableView.reloadData()
      }
  }
}

