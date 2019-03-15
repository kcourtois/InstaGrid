//
//  ImageGridView.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ImageGridView: UIView {
    //contains an enum to select current layout
    var layout:Layouts = .Layout1 {
        didSet {
            setLayout(layout)
        }
    }
    
    //stores the current contentView.
    var contentView:StandardLayout? = nil
    
    //Returns true if images were picked by user
    var isImageGridFilled:Bool {
        if let theView = contentView {
            return theView.isImageGridFilled()
        }
        else {
            return false
        }
    }
    
    
    // Adds the right layout UIView as a subview
    private func setLayout(_ layout:Layouts) {
        removeSubviews()
        switch layout {
            case .Layout1:
                contentView = Layout1(frame: bounds)
            case .Layout2:
                contentView = Layout2(frame: bounds)
            case .Layout3:
                contentView = Layout3(frame: bounds)
        }
        //Unwrap of the contentView to add it to the imageGridView
        if let theView = contentView {
            theView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            theView.translatesAutoresizingMaskIntoConstraints = true
            theView.frame = bounds
            addSubview(theView)
        }
    }
    
    //func to remove all subviews in ImageGridView
    private func removeSubviews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}
