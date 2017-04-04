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
    
    
    @IBAction func uploadRoastPicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
