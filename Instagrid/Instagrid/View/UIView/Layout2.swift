//
//  Layout2.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class Layout2: StandardLayout {

    @IBOutlet var contentView: UIView!
    @IBOutlet var images:[UIImageView]!
    
    override func commonInit() {
        super.commonInit()
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func botViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 0)
    }
    
    @IBAction func topLeftViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 1)
    }
    
    @IBAction func topRightViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 2)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            images[lastTappedImage].image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
