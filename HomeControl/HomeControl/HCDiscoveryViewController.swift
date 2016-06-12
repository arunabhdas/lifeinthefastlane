//
//  HCDiscoveryViewController.swift
//  HomeControl
//
//  Created by coder on 1/28/16.
//  Copyright © 2016 Arunabh Das. All rights reserved.
//

import UIKit
import HomeKit

class HCDiscoveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate {
    var tableView: UITableView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.colorBlue
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)!], forState: UIControlState.Normal)
        if let navFont = UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize) {
            let titleDict: NSDictionary = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navFont
            ]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]
        }
        view.backgroundColor = Constants.Colors.colorLightBlue
        
        let tableViewFrame = self.view.frame
        // let xMargin:CGFloat = 30.0
        // let yTopMargin:CGFloat = 5.0
        // tableViewFrame.origin.x += xMargin
        // tableViewFrame.origin.y += yTopMargin
        // tableViewFrame.size.width -= 2.0 * xMargin
        // tableViewFrame.size.height /= 1.0
        
        // tableView = UITableView(frame: self.view.frame)
        tableView = UITableView(frame: tableViewFrame)
        
        tableView.registerClass(ProductItemCell.self, forCellReuseIdentifier: "ProductItemCell")
        // tableView.registerNib(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Constants.Colors.colorLightBlue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        doReload()
    }
    
    func doReload() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: UITableViewDatasource
    @objc func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return self.imageTexts.count
        
        return accessories.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath was called")
        let cellIdentifier: String = "ProductItemCell"
        let cell: ProductItemCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProductItemCell
        cell.backgroundColor = UIColor.clearColor()
        cell.thumbnailImageView.image = UIImage.fontAwesomeIconWithName(.CircleThin, textColor: UIColor.whiteColor(), size: CGSizeMake(50, 50))
        let accessory = accessories[indexPath.row] as HMAccessory
        cell.titleLabel.text = accessory.name
        
        /*
        let thumbnailFile = self.products[indexPath.row].smallImageFile
        if (thumbnailFile != nil) {
        thumbnailFile!.getDataInBackgroundWithBlock({ (thumbnailData:NSData?, error: NSError?) -> Void in
        if (error == nil) {
        if let thumbnailData = thumbnailData {
        self.products[indexPath.row].mainImage = UIImage(data: thumbnailData)
        cell.thumbnailImageView.image = UIImage(data: thumbnailData)!
        }
        }
        })
        }
        */
        
        return cell
    }
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Accessory Delegate
    
    // Informs us when we've located a new accessory in the home
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory)
        doReload()
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
        doReload()
    }

}
