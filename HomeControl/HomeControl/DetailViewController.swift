//
//  DetailViewController.swift
//  Central
//
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate  {
    var urls: [String] = []
    var captionLabel: UILabel!
    var doneButton: UIButton!
    var currentMainImage: UIImage?
    var currentName: String?
    var currentUsername: String?
    var currentProductObjectId: String?
    // var fullScreenDetailViewController: FullScreenDetailViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeStaticViews()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Constants.Colors.colorLightBlue
        
        
        let panGestureRecognizer = UIPanGestureRecognizer()
        self.view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        
        // 1
        let firstRowImageView               = UIImageView()
        firstRowImageView.heightAnchor.constraintEqualToConstant(60.0).active = true
        firstRowImageView.widthAnchor.constraintEqualToConstant(60.0).active = true
        firstRowImageView.image = UIImage(named: "default")
        firstRowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // 2
        let secondRowImageView = UIImageView()
        secondRowImageView.heightAnchor.constraintEqualToConstant(50.0).active = true
        secondRowImageView.widthAnchor.constraintEqualToConstant(50.0).active = true
        secondRowImageView.clipsToBounds = true
        secondRowImageView.contentMode = UIViewContentMode.ScaleAspectFit
        secondRowImageView.image = UIImage.fontAwesomeIconWithName(.CircleThin, textColor: UIColor.whiteColor(), size: CGSizeMake(50, 50))
        secondRowImageView.translatesAutoresizingMaskIntoConstraints = false
        if (self.currentMainImage != nil) {
            print("currentMainImage not nil")
            secondRowImageView.image = self.currentMainImage
        } else {
            print("currentMainImage nil")
            secondRowImageView.image = UIImage.fontAwesomeIconWithName(.CircleThin, textColor: UIColor.whiteColor(), size: CGSizeMake(50, 50))
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        secondRowImageView.userInteractionEnabled = true
        secondRowImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // 3
        captionLabel = UILabel()
        captionLabel.widthAnchor.constraintEqualToConstant(300.0).active = true
        captionLabel.heightAnchor.constraintEqualToConstant(37.5).active = true
       
        print("Current Name\(currentProductObjectId)")
        
        if (currentName != nil) {
            captionLabel.text = currentName
        } else {
            captionLabel.text = "_"
        }
        
        captionLabel.font = UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)
        captionLabel.textColor = UIColor.whiteColor()
        captionLabel.textAlignment = .Center
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 6
        doneButton = UIButton()
        doneButton.widthAnchor.constraintEqualToConstant(300.0).active = true
        doneButton.heightAnchor.constraintEqualToConstant(37.5).active = true
        doneButton.setTitle(Constants.Labels.kOnOff, forState: .Normal)
        doneButton.backgroundColor = Constants.Colors.colorBlue
        doneButton.layer.shadowOpacity = 0.55
        doneButton.layer.shadowRadius = 5.0
        // doneButton.layer.shadowColor = colorTwoShadow.CGColor
        doneButton.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        
        
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.Vertical
        stackView.distribution  = UIStackViewDistribution.EqualSpacing
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing   = 10.0
        
        
        stackView.addArrangedSubview(firstRowImageView)
        stackView.addArrangedSubview(secondRowImageView)
        stackView.addArrangedSubview(captionLabel)
        stackView.addArrangedSubview(doneButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        
        stackView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        let constraint = NSLayoutConstraint(
            item: stackView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: topLayoutGuide,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 10.0
        )
        self.view.addConstraint(constraint)
        
        

    }
    
    /*
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
    }
    */
    
    func imageTapped(img: AnyObject) {
        print("imageTapped")
       /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.performSegueWithIdentifier("DetailToFullScreenDetailSegue", sender: self)
        */
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "DetailToFullScreenDetailSegue") {
            
            // let detailVC =  segue.destinationViewController as! FullScreenDetailViewController
            // detailVC.currentImage = self.currentImage
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareButtonTapped() {
        /*
        if let user = PFUser.currentUser()  {
            
            let targetUserQuery = PFUser.query()
            targetUserQuery?.whereKey("username", equalTo: self.usernameTextField.text!)
            targetUserQuery?.getFirstObjectInBackgroundWithBlock({ (result: PFObject?, error: NSError?) -> Void in
                if let targetUser = result as? PFUser {
                    self.targetUser = targetUser
                    let shareActivity = PFObject(className: kPAPActivityClassKey)
                    shareActivity.setObject(PFUser.currentUser()!, forKey: kPAPActivityFromUserKey)
                    shareActivity.setObject(self.targetUser!, forKey: kPAPActivityToUserKey)
                    shareActivity.setObject(kPAPActivityTypeShare, forKey: kPAPActivityTypeKey)
                    
                    let followACL = PFACL(user: PFUser.currentUser()!)
                    followACL.setPublicReadAccess(true)
                    shareActivity.ACL = followACL
                    
                    shareActivity.saveInBackgroundWithBlock { (succeeded, error) in
                        self.shareButton.enabled = false
                        self.shareButton.backgroundColor = UIColor.grayColor()
                    }
                    
                }
            })

        }
        */
    }
    
    func doneButtonTapped() {
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    //MARK: Gestures
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // self.usernameTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        // self.usernameTextField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // usernameTextField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func initializeStaticViews() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
         self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)!], forState: UIControlState.Normal)
    }
}