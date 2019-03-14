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
    
    //Adds tap gestures to imageViews in array
    func initTapGesures(images:[UIImageView]) {
        for imageView in images {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgViewTapped(sender:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    //func triggered when an imageview is tapped. Sends a notification to the viewcontroller
    @objc private func imgViewTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            lastTappedImage = view.tag
            let name = Notification.Name(rawValue: "didTapImage")
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["layout": self])
        }
    }
    
    //Get class name and turn it to a string
    private func selfName()->String{
        let thisType = type(of: self)
        return String(describing: thisType)
    }

    //Handles the picker dismiss when user taps Cancel
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension UIImagePickerController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
