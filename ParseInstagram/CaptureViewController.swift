//
//  CaptureViewController.swift
//  ParseInstagram
//
//  Created by Devon Maguire on 3/12/16.
//  Copyright © 2016 Devon Maguire. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!

    var vc = UIImagePickerController()
    var captureImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAddImage(sender: AnyObject) {
        // add image
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func onUploadImage(sender: AnyObject) {
        // resize image
        resize(captureImage, newSize: CGSize(width: 570, height: 342))
        
        // upload image
        if let captureImage = captureImage {
            Post.postUserImage(captureImage, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
                if success == true {
                    // transition back
                    self.tabBarController?.selectedIndex = 0
                    self.captionTextField.text = ""
                    self.imageButton.setImage(nil, forState: .Normal)
                } else {
                    print(error?.localizedDescription)
                }
            }
        } else {
            // do nothing
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let favoriteImage = captureImage
            imageButton.setImage(favoriteImage, forState: .Normal)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
