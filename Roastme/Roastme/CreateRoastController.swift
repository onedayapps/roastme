//
//  CreateRoastController.swift
//  Roastme
//
//  Created by Matthew Belley on 2017-04-01.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit


class CreateRoastController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var roastCaption: UITextView!
    let currentToken:String? = User.sharedInstance.authToken
    
    // TODO: add default image underneath user image to look like a placeholder if no image is selected
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if roastCaption.text == ""{
            print("Error: Please add a caption.")
            // TODO: add prompt for user to add a caption
        } else if previewImage.image == nil{
            print("Error: Please add a picture.")
            // TODO: add protm for user to add a picture
        } else{
            RoastAPI.createRoast(authToken: currentToken!, roastImage: previewImage.image!, caption: roastCaption.text!, callback: {
                (success:createRoastResponse?, error:LoginErrorResponse?) in
                if success != nil {
                    self.dismiss(animated: true, completion: nil)
                    // print(success?.response!)
                } else {
                    print("back to the drawing board")
                    print(error!)
                }
            })
        }
    }
    
    @IBAction func uploadRoastPicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
            /*  //this code should the user to pick an image from their photo library
             if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
             imagePicker.allowsEditing = false  //check what options for editing exist
             self.present(imagePicker, animated: true, completion: nil)
 
            */
            //previewImage.image = [UIImagePickerControllerOriginalImage] as UIImage
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        previewImage.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateRoastController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
