//
//  PostItemCell.swift
//  Central
//
//

import UIKit

class ProductItemCell : UITableViewCell {
    var thumbnailImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    // let colorOne:UIColor = UIColor(red:  74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 100.0/100.0)
    // var colorTwo:UIColor = UIColor(red:  164/255.0, green: 199/255.0, blue: 240/255.0, alpha: 100.0/100.0)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.titleLabel.textColor = Constants.Colors.colorLightBlue
        self.titleLabel.font = UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)
        let placeholder = UIImage.fontAwesomeIconWithName(.CircleThin, textColor: Constants.Colors.colorLightBlue, size: CGSizeMake(50, 50))
        thumbnailImageView.image = placeholder
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.frame = CGRectMake(10, 10, 40, 40)
        titleLabel.frame = CGRectMake(60, 0, self.frame.width - 10, 60)
        titleLabel.textColor = UIColor.whiteColor()
        descriptionLabel.frame = CGRectMake(200, 10, self.frame.width - 20, 25)
        descriptionLabel.textColor = UIColor.whiteColor()
        // dateLabel = UILabel(frame: CGRectMake(0, 0, 0, 0))
        // dateLabel.textColor = UIColor.blackColor()
        
        
    }
  
    /*
    override func layoutSubviews() {
        self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width - 50, self.bounds.size.height)
        super.layoutSubviews()
    }
    */
    
}

