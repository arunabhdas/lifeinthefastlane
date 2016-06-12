//
//  DASBaseViewController.swift
//  HomeControl
//
//

import UIKit
import HomeKit
class HCBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMHomeManagerDelegate {
    var tableView: UITableView!
    var products = [Product]()
    var detailViewController: DetailViewController?
    
    let homeManager = HMHomeManager()
    var activeHome: HMHome?
    var activeRoom: HMRoom?
    
    var lastSelectedIndexRow = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        homeManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.colorBlue
        self.navigationController?.navigationBar.translucent = false
        if let navFont = UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize) {
            let titleDict: NSDictionary = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navFont
            ]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]
        }
        view.backgroundColor = Constants.Colors.colorLightBlue
        
        initializeStaticViews()
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
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        doReload()
    }
    func doReload() {
        let product1: Product = Product(productNumber: 1, name: "Genesis Light Bulb", desc: "Genesis Light Bulb")
        products.append(product1)
        let product2: Product = Product(productNumber: 2, name: "Genesis Fridge", desc: "Genesis Fridge")
        products.append(product2)
       
        let acc1: HMAccessory = HMAccessory()
        acc1.setValue("Dummmy Light Bulb", forKey: "name")
        
        self.tableView.reloadData()
    }
    
    func updateControllerWithHome(home: HMHome) {
        if let room = home.rooms.first as HMRoom? {
            activeRoom = room
            title = room.name + " Devices"
        }
    }
    func initializeStaticViews() {
        title = Constants.Labels.kApplicationName
        /*
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: "presentLeftMenuViewController")
        */
        let leftImage = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        let leftImageOriginal = leftImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImageOriginal, style: .Plain, target: self, action: nil)
        
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)!], forState: UIControlState.Normal)
        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: "presentRightMenuViewController")
        */
        
        let rightImage = UIImage.fontAwesomeIconWithName(.Sliders, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        let rightImageOriginal = rightImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImageOriginal, style: .Plain, target: self, action: "showDiscovery")
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)!], forState: UIControlState.Normal)
    }
   
    func showDiscovery() {
        self.performSegueWithIdentifier("showDiscovery", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        
        if let accessories = activeRoom?.accessories {
            print("Number included \(accessories.count)")
            return accessories.count
        }
        return 0
        
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let accessories = activeRoom?.accessories {
            if (accessories.count == 0) {
                return "No devices found";
            }
            
        }
        return "Devices"
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath was called")
        let cellIdentifier: String = "ProductItemCell"
        let cell: ProductItemCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProductItemCell
        cell.backgroundColor = UIColor.clearColor()
        cell.thumbnailImageView.image = UIImage.fontAwesomeIconWithName(.CircleThin, textColor: UIColor.whiteColor(), size: CGSizeMake(50, 50))
        
        let accessory = activeRoom!.accessories[indexPath.row] as HMAccessory
        cell.titleLabel.text = accessory.name
        
        // ignore the information service
        cell.descriptionLabel.text = "\(accessory.services.count - 1) service(s)"
        
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        detailViewController = storyboard.instantiateViewControllerWithIdentifier("detail") as? DetailViewController
       /*
        self.currentName = self.products[indexPath.row].name
        self.currentProductObjectId = self.products[indexPath.row].objectId
        print("currentProductObjectId\(self.products[indexPath.row].objectId)")
        if (detailViewController != nil) {
            
            detailViewController!.currentMainImage = self.products[indexPath.row].mainImage
            detailViewController!.currentName = self.currentName
            detailViewController!.currentProductObjectId = self.currentProductObjectId
            print("currentProductObjectId\(currentProductObjectId)")
        }
        */
        self.navigationController?.pushViewController(detailViewController!, animated: true)
        
    }
    
    // MARK: - Home Delegate
    
    // Homes are not loaded right away. Monitor the delegate so we catch the loaded signal.
    func homeManager(manager: HMHomeManager, didAddHome home: HMHome) {
        
    }
    
    func homeManager(manager: HMHomeManager, didRemoveHome home: HMHome) {
        
    }
    
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        if let home = homeManager.primaryHome {
            activeHome = home
            updateControllerWithHome(home)
        } else {
            initialHomeSetup()
        }
        doReload()
    }
    // MARK: - Setup
    
    // Create our primary home if it doens't exist yet
    private func initialHomeSetup() {
        homeManager.addHomeWithName("7 Light Avenue", completionHandler: { (home, error) in
            if error != nil {
                print("Something went wrong when attempting to create our home. \(error?.localizedDescription)")
            } else {
                if let discoveredHome = home {
                    // Add a new room to our home
                    discoveredHome.addRoomWithName("Home", completionHandler: { (room, error) in
                        if error != nil {
                            print("Something went wrong when attempting to create our room. \(error?.localizedDescription)")
                        } else {
                            self.updateControllerWithHome(discoveredHome)
                        }
                    })
                    
                    // Assign this home as our primary home
                    self.homeManager.updatePrimaryHome(discoveredHome, completionHandler: { (error) in
                        if error != nil {
                            print("Something went wrong when attempting to make this home our primary home. \(error?.localizedDescription)")
                        }
                    })
                } else {
                    print("Something went wrong when attempting to create our home")
                }
                
            }
        })
    }
    
    func homeManagerDidUpdatePrimaryHome(manager: HMHomeManager) {
        
    }
    

}
