//
//  ViewController.swift
//  Instagrid
//
//  Created by Kévin Courtois on 05/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var panelImg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //put shadows behind the image panel
        panelImg.layer.shadowColor = UIColor.black.cgColor
        panelImg.layer.shadowOffset = CGSize(width: 0, height: 2)
        panelImg.layer.shadowOpacity = 0.8
    }

}

