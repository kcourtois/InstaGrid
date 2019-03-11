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
    var imagesShown = [UIImage]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        print(selfName())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        //Load xib by name
        Bundle.main.loadNibNamed(selfName(), owner: self, options: nil)
    }
    
    func selfName()->String{
        let thisType = type(of: self)
        return String(describing: thisType)
    }
    
    func changeImage(lastTappedImage: Int) {
        self.lastTappedImage = lastTappedImage
        let name = Notification.Name(rawValue: "didTapImage")
        NotificationCenter.default.post(name: name, object: nil, userInfo: ["layout": self])
    }

    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
        /*
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("yay")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
*/
    
}
