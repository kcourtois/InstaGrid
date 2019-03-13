//
//  ImageGridView.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ImageGridView: UIView {
    
    var layout:Layouts = .Layout1 {
        didSet {
            setLayout(layout)
        }
    }
    
    // Adds the right layout UIView as a subview
    private func setLayout(_ layout:Layouts) {
        removeSubviews()
        var contentView:StandardLayout
        switch layout {
            case .Layout1:
                contentView = Layout1(frame: bounds)
            case .Layout2:
                contentView = Layout2(frame: bounds)
            case .Layout3:
                contentView = Layout3(frame: bounds)
        }
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    //func to remove all subviews in ImageGridView
    private func removeSubviews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}
