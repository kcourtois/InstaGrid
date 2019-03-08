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
                print("l1")
            case .Layout2:
                print("l2")
            case .Layout3:
                print("l3")
        }
    }
}
