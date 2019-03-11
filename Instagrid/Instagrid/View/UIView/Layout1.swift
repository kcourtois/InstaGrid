//
//  Layout1.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class Layout1: StandardLayout {

    @IBOutlet var contentView: UIView!
    @IBOutlet var images:[UIImageView]!
    
    override func commonInit() {
        super.commonInit()
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        var imagesPicked = [UIImage]()
        if let imageArray = UserDefaults.standard.array(forKey: "imagesPickedByUser") as? [UIImage] {
            imagesPicked = imageArray
        }
        for (index, imageView) in images.enumerated() {
            if index < imagesPicked.count {
                imageView.image = imagesPicked[index]
                print("loaded")
            }
        }
    }
    
    //Saves images picked by user in UserDefaults
    func saveImagesPicked() {
        var imagesPicked = [UIImage]()
        for imgView in images {
            if let img = imgView.image {
                imagesPicked.append(img)
                print("append")
            }
        }
        let imagesArrayData = NSKeyedArchiver.archivedData(withRootObject: imagesPicked)
        UserDefaults.standard.set(imagesArrayData, forKey: "imagesPickedByUser")
    }
    
    @IBAction func topViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 0)
    }
    
    @IBAction func botLeftViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 1)
    }
    
    @IBAction func botRightViewTap(_ sender: Any) {
        changeImage(lastTappedImage: 2)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            images[lastTappedImage].image = image
        }
        saveImagesPicked()
        picker.dismiss(animated: true, completion: nil)
    }
}
