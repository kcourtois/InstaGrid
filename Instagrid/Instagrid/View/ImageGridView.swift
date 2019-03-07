//
//  ImageGridView.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ImageGridView: UIView {
    @IBOutlet private var topButton: UIButton!
    @IBOutlet private var botButton: UIButton!
    @IBOutlet private var topLeftButton: UIButton!
    @IBOutlet private var botLeftButton: UIButton!
    @IBOutlet private var topRightButton: UIButton!
    @IBOutlet private var botRightButton: UIButton!
    
    var layout:Layouts = .Layout1 {
        didSet {
            setLayout(layout)
        }
    }
    
    // Shows/Hides buttons to match the selected layout
    private func setLayout(_ layout:Layouts) {
        switch layout {
            case .Layout1:
                topButton.isHidden = false;
                botLeftButton.isHidden = false;
                botRightButton.isHidden = false;
                topLeftButton.isHidden = true;
                topRightButton.isHidden = true;
                botButton.isHidden = true;
            case .Layout2:
                topButton.isHidden = true;
                botLeftButton.isHidden = true;
                botRightButton.isHidden = true;
                topLeftButton.isHidden = false;
                topRightButton.isHidden = false;
                botButton.isHidden = false;
            case .Layout3:
                topButton.isHidden = true;
                botLeftButton.isHidden = false;
                botRightButton.isHidden = false;
                topLeftButton.isHidden = false;
                topRightButton.isHidden = false;
                botButton.isHidden = true;
        }
    }
}
