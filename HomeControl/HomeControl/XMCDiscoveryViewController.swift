//
//  HCDiscoveryViewController.swift
//
//

import UIKit
import HomeKit

class XMCDiscoveryViewController: UITableViewController, HMAccessoryBrowserDelegate {

    let homeManager = HMHomeManager()
    let browser = HMAccessoryBrowser()
    
    var accessories = [HMAccessory]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Searching"
        
        // The delegate will inform us about accessory activity (discovered / lost)
        browser.delegate = self
        
        // Immediately start the discovery process
        browser.startSearchingForNewAccessories()
    
        // Searching for accessories is an expensive operation. Stop the process within
        // a reasonable time to avoid unnessarily using battery & other resources
        NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "stopSearching", userInfo: nil, repeats: false)
    }
    
    func stopSearching() {
        title = "Discovered"
        print ("Count : \(accessories.count)")
        browser.stopSearchingForNewAccessories()
        
    }
    
    // MARK: - Table
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("accessoryId") {
            let accessory = accessories[indexPath.row] as HMAccessory
            cell.textLabel?.text = accessory.name
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let accessory = accessories[indexPath.row] as HMAccessory

        if let room = homeManager.primaryHome?.rooms.first as HMRoom? {
            homeManager.primaryHome?.addAccessory(accessory, completionHandler: { (error) -> Void in
                if error != nil {
                    print("Something went wrong when attempting to add an accessory to our home. \(error?.localizedDescription)")
                } else {
                    self.homeManager.primaryHome?.assignAccessory(accessory, toRoom: room, completionHandler: { (error) -> Void in
                        if error != nil {
                            print("Something went wrong when attempting to add an accessory to our home. \(error?.localizedDescription)")
                        } else {
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    })
                }
            })
        }
    }
    
    
    // MARK: - Accessory Delegate
    
    // Informs us when we've located a new accessory in the home
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory)
        tableView.reloadData()
    }
    
    // Inform us when a device has been removed... so something that was previously 
    // reachable, but is no longer.
    func accessoryBrowser(browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        var index = 0
        for item in accessories {
            if item.name == accessory.name {
                accessories.removeAtIndex(index)
                break; // done
            }
            ++index
        }
        tableView.reloadData()
    }
}
