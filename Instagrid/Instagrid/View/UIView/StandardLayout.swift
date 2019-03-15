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
    var imageViews = [UIImageView]()
    
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
        let contentView = Bundle.main.loadNibNamed(selfName(), owner: self, options: nil)?.first as? UIView ?? UIView()
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    //Adds tap gestures to imageViews in array
    func initTapGesures() {
        for imageView in imageViews {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgViewTapped(sender:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    //func triggered when an imageview is tapped. Sends a notification to the viewcontroller
    @objc private func imgViewTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            lastTappedImage = view.tag
            let name = Notification.Name(rawValue: NotificationStrings.didTapImageNotificationName)
            NotificationCenter.default.post(name: name, object: nil, userInfo: [NotificationStrings.didTapImageParameterKey: self])
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViews[lastTappedImage].image = image
        }
        picker.dismiss(animated: true, completion: nil)
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
    
    //Returns false if all images are not filled by the user
    func isImageGridFilled() -> Bool {
        var imagesFilled = true
        for imageView in imageViews {
            if imageView.image == #imageLiteral(resourceName: "Plus") {
                imagesFilled = false
            }
        }
        return imagesFilled
    }
    
}

extension UIImagePickerController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
