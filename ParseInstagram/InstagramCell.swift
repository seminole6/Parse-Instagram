//
//  InstagramCell.swift
//  ParseInstagram
//
//  Created by Devon Maguire on 3/12/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramCell: UITableViewCell {

    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var getPhotoandCaption: PFObject! {
        didSet {
            self.captionLabel.text = getPhotoandCaption["caption"] as? String
            
            if let userPicture = getPhotoandCaption["media"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.instaImageView.image = UIImage(data:imageData!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
