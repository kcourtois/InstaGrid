//
//  Layout3.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class Layout3: UIView, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var botLeftImageView: UIImageView!
    @IBOutlet weak var botRightImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        //Load xib by name
        Bundle.main.loadNibNamed("Layout3", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func topLeftViewTap(_ sender: Any) {
        //changeImage(imageView: topLeftImageView)
    }
    
    @IBAction func topRightViewTap(_ sender: Any) {
        //changeImage(imageView: topRightImageView)
    }
    
    @IBAction func botLeftViewTap(_ sender: Any) {
        //changeImage(imageView: botLeftImageView)
    }
    
    @IBAction func botRightViewTap(_ sender: Any) {
        //changeImage(imageView: botRightImageView)
    }
}
