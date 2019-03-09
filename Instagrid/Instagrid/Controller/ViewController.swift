//
//  ViewController.swift
//  Instagrid
//
//  Created by Kévin Courtois on 05/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageGridView: ImageGridView!
    @IBOutlet weak var layoutSelectionView: LayoutSelectionView!
    @IBOutlet weak var swipeStackView: SwipeStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //put shadows behind the image grid
        imageGridView.layer.shadowColor = UIColor.black.cgColor
        imageGridView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageGridView.layer.shadowOpacity = 0.8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Sets view to layout 1
        setLayout(layout: .Layout1)
        
        //Notification observer
        let name = Notification.Name(rawValue: "didSelectLayout")
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectLayout(_:)), name: name, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        updateOrientation()
    }
    
    //Changes layout for imageGridView and layoutSelectionView
    func setLayout(layout: Layouts) {
        imageGridView.layout = layout
        layoutSelectionView.layout = layout
    }
    
    //Triggers on notification didSelectLayout
    @objc func onDidSelectLayout(_ notification:Notification) {
        if let data = notification.userInfo as? [String: Layouts]
        {
            for (_, layout) in data
            {
                setLayout(layout: layout)
            }
        }
    }
    
    //Updates swipeStackView's orientation
    func updateOrientation() {
        if UIDevice.current.orientation.isLandscape {
            swipeStackView.orientation = .Landscape
        } else {
            swipeStackView.orientation = .Portrait
        }
    }
}

