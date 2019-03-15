//
//  LayoutSelectionView.swift
//  Instagrid
//
//  Created by Kévin Courtois on 07/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class LayoutSelectionView: UIView {
    @IBOutlet private var Layout1_Button: UIButton!
    @IBOutlet private var Layout2_Button: UIButton!
    @IBOutlet private var Layout3_Button: UIButton!
    
    var layout:Layouts = .Layout1 {
        didSet {
            setLayout(layout)
        }
    }
    
    //Shows/Hides buttons to get the "selected" effect on the layout menu
    private func setLayout(_ layout:Layouts) {
        switch layout {
        case .Layout1:
            Layout1_Button.setBackgroundImage(#imageLiteral(resourceName: "Selected"), for: .normal);
            Layout2_Button.setBackgroundImage(nil, for: .normal);
            Layout3_Button.setBackgroundImage(nil, for: .normal);
        case .Layout2:
            Layout1_Button.setBackgroundImage(nil, for: .normal);
            Layout2_Button.setBackgroundImage(#imageLiteral(resourceName: "Selected"), for: .normal);
            Layout3_Button.setBackgroundImage(nil, for: .normal);
        case .Layout3:
            Layout1_Button.setBackgroundImage(nil, for: .normal);
            Layout2_Button.setBackgroundImage(nil, for: .normal);
            Layout3_Button.setBackgroundImage(#imageLiteral(resourceName: "Selected"), for: .normal);
        }
    }
    
    @IBAction func layoutOneClicked() {
        postNotification(layout: .Layout1)
    }
    
    @IBAction func layoutTwoClicked() {
        postNotification(layout: .Layout2)
    }
    
    @IBAction func layoutThreeClicked() {
        postNotification(layout: .Layout3)
    }
    
    private func postNotification(layout:Layouts) {
        let name = Notification.Name(rawValue: NotificationStrings.didSelectLayoutNotificationName)
        NotificationCenter.default.post(name: name, object: nil, userInfo: [NotificationStrings.didSelectLayoutParameterKey: layout])
    }
}
