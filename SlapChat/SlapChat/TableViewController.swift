//
//  TableViewController.swift
//  SlapChat
//
//  Created by susan lovaglio on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
   
   let dataStore = DataStore.sharedDataStore
   var recipientSelected: Recipient?
   var recipientMessages = [Message]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let recipientSelected = recipientSelected {
         recipientMessages = Array(recipientSelected.messages)
      }
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(true)
      if let recipientSelected = recipientSelected {
         recipientMessages = Array(recipientSelected.messages)
      }
      tableView.reloadData()
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipientMessages.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let newCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
      
      newCell.textLabel?.text = recipientMessages[indexPath.row].content
      return newCell
   }
   
   @IBAction func refreshTapped(sender: AnyObject) {
      dataStore.fetchDataByEntity("Message", key: "createdAt")
      tableView.reloadData()
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      let destinationVC = segue.destinationViewController as? AddMessageViewController
      
      if let addMessageVC = destinationVC {
         addMessageVC.recipientToAddTo = recipientSelected
      }
   }
}
