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
    }
    
    override func viewWillLayoutSubviews() {
        updateOrientation()
    }
    
    @IBAction func layoutOneClicked() {
        setLayout(layout: .Layout1)
    }
    
    @IBAction func layoutTwoClicked() {
        setLayout(layout: .Layout2)
    }
    
    @IBAction func layoutThreeClicked() {
        setLayout(layout: .Layout3)
    }
    
    //Changes layout for imageGridView and layoutSelectionView
    func setLayout(layout: Layouts) {
        imageGridView.layout = layout
        layoutSelectionView.layout = layout
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

