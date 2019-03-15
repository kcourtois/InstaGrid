//
//  Layout2.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class Layout2: StandardLayout {

    @IBOutlet var images:[UIImageView]!
    
    override func commonInit() {
        super.commonInit()
        imageViews = images
        initTapGesures()
    }
}
