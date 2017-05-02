//
//  MasterViewController.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  
  @IBOutlet weak var showHideDetailsButton: UIBarButtonItem!
  
  var pancakeHouses = [PancakeHouse]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let seedPancakeHouses = PancakeHouse.loadDefaultPancakeHouses() {
      pancakeHouses += seedPancakeHouses
      pancakeHouses = pancakeHouses.sorted { $0.name < $1.name }
    }
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        if let controller = (segue.destination as! UINavigationController).topViewController as? PancakeHouseViewController {
          controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
          controller.navigationItem.leftItemsSupplementBackButton = true
          let pancakeHouse = pancakeHouses[indexPath.row]
          controller.pancakeHouse = pancakeHouse
        }
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pancakeHouses.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let pancakeHouse = pancakeHouses[indexPath.row]
    if let cell = cell as? PancakeHouseTableViewCell {
      cell.pancakeHouse = pancakeHouse
    } else {
      cell.textLabel?.text = pancakeHouse.name
    }
    
    return cell
  }
}

