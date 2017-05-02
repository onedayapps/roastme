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

    @IBAction func createRoastButton(_ sender: Any) {
        if roastCaption.text == ""{
            print(")Error: Please add a caption.")
        } else if previewImage.image == nil{
            print("Error: Please add a picture.")
        } else{
            RoastAPI.createRoast(authToken: currentToken!, roastImage: previewImage.image!, caption: roastCaption.text!, callback: {
                (success:createRoastResponse?, error:LoginErrorResponse?) in
                if success != nil {
                    print("submitted")
                } else {
                    print("back to the drawing board")
                }
            })
        }

    }
    
    //set keyboard type for textview
    
    
    @IBAction func uploadRoastPicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
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
    
   /*
    @IBAction func newRoast(_ sender: UIButton) {
            }*/
}
