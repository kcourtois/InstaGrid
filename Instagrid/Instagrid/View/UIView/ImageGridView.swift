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
    
    // Shows/Hides buttons to match the selected layout
    private func setLayout(_ layout:Layouts) {
        switch layout {
            case .Layout1:
                removeSubviews()
                addSubview(Layout1(frame: bounds))
            case .Layout2:
                removeSubviews()
                addSubview(Layout2(frame: bounds))
            case .Layout3:
                removeSubviews()
                addSubview(Layout3(frame: bounds))
        }
    }
    
    //func to remove all subviews in ImageGridView
    private func removeSubviews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}
