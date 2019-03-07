//
//  SwipeStackView.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class SwipeStackView: UIStackView {

    @IBOutlet private var arrowImg: UIImageView!
    @IBOutlet private var swipeLabel: UILabel!
    
    enum Orientation {
        case Portrait, Landscape
    }
    
    var orientation:Orientation = .Portrait {
        didSet {
            setOrientation(orientation)
        }
    }
    
    //Changes label text and arrow orientation for landscape and portrait
    private func setOrientation(_ orientation:Orientation) {
        switch orientation {
        case .Portrait:
            arrowImg.image = #imageLiteral(resourceName: "arrowUp")
            swipeLabel.text = "Swipe up to share"
        case .Landscape:
            arrowImg.image = #imageLiteral(resourceName: "arrowLeft")
            swipeLabel.text = "Swipe left to share"
        }
    }

}
