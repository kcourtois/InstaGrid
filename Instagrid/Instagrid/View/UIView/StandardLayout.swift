//
//  StandardLayout.swift
//  Instagrid
//
//  Created by Kévin Courtois on 09/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class StandardLayout: UIView, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //Index for last tapped imageView
    var lastTappedImage = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    //Initalisation of the xib
    func commonInit() {
        //Load xib by name
        Bundle.main.loadNibNamed(selfName(), owner: self, options: nil)
    }
    
    //Get class name and turn it to a string
    func selfName()->String{
        let thisType = type(of: self)
        return String(describing: thisType)
    }
    
    //stores last tapped image index and post notification to the controller
    func changeImage(lastTappedImage: Int) {
        self.lastTappedImage = lastTappedImage
        let name = Notification.Name(rawValue: "didTapImage")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["layout": self])
    }

    //Handles the picker dismiss when user taps Cancel
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
