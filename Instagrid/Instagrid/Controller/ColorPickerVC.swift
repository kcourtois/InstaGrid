//
//  colorPickerVC.swift
//  Instagrid
//
//  Created by Kévin Courtois on 14/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController {

    @IBOutlet weak var pickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.layer.cornerRadius = 10
        self.pickerView.layer.masksToBounds = true
    }
    @IBAction func closePopUp() {
        if let presenter = presentingViewController as? MainVC {
            
        }
        dismiss(animated: true, completion: nil)
    }
}
