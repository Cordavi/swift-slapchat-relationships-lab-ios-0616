//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Michael Amundsen on 7/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {
   
   let dataStore = DataStore.sharedDataStore
   var recipients = [Recipient]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      recipients = dataStore.fetchDataByEntity("Recipient", key: nil) as? [Recipient] ?? []
      
      if recipients.isEmpty {
         dataStore.generateRecipientTestData()
         recipients = dataStore.fetchDataByEntity("Recipient", key: nil) as? [Recipient] ?? []
      }
      
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipients.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let recipientCell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath)
      recipientCell.textLabel?.text = recipients[indexPath.row].name
      return recipientCell
   }
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

      
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      let destinationView = segue.destinationViewController as? TableViewController
      guard let messageTableView = destinationView else {
         return
      }
      
      let selectedIndexPath = self.tableView.indexPathForSelectedRow
      guard let selectedRow = selectedIndexPath else {
         return
      }
      
      messageTableView.recipientSelected = recipients[selectedRow.row]
   }
   
}
