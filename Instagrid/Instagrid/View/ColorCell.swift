//
//  ColorCell.swift
//  Instagrid
//
//  Created by Kévin Courtois on 14/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cellInit()
    }
    
    func cellInit() {
        layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1)
    }
}
