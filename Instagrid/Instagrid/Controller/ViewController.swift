//
//  ViewController.swift
//  Instagrid
//
//  Created by Kévin Courtois on 05/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var imageGridView: ImageGridView!
    @IBOutlet weak var layoutSelectionView: LayoutSelectionView!
    @IBOutlet weak var swipeStackView: SwipeStackView!
    
    private var imageView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //put shadows behind the image grid
        imageGridView.layer.shadowColor = UIColor.black.cgColor
        imageGridView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageGridView.layer.shadowOpacity = 0.8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Sets view to layout 1
        //setLayout(layout: .Layout1)
        
        //Notification observer for didSelectLayout
        let nameSelectNotif = Notification.Name(rawValue: "didSelectLayout")
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectLayout(_:)), name: nameSelectNotif, object: nil)
        
        //Notification observer for didTapImage
        let nameTapImageNotif = Notification.Name(rawValue: "didTapImage")
        NotificationCenter.default.addObserver(self, selector: #selector(onDidTapImage(_:)), name: nameTapImageNotif, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        updateOrientation()
    }
    
    //Changes layout for imageGridView and layoutSelectionView
    private func setLayout(layout: Layouts) {
        imageGridView.layout = layout
        layoutSelectionView.layout = layout
    }
    
    //Updates swipeStackView's orientation
    private func updateOrientation() {
        if UIDevice.current.orientation.isLandscape {
            swipeStackView.orientation = .Landscape
        } else {
            swipeStackView.orientation = .Portrait
        }
    }
    
    //Triggers on notification didSelectLayout
    @objc private func onDidSelectLayout(_ notification:Notification) {
        if let data = notification.userInfo as? [String: Layouts]
        {
            for (_, layout) in data
            {
                setLayout(layout: layout)
            }
        }
    }
    
    //Triggers on notification didTapImage
    @objc private func onDidTapImage(_ notification:Notification) {
        if let data = notification.userInfo as? [String: StandardLayout]
        {
            for (_, layout) in data
            {
                if (checkPermission()){
                    showImagePicker(delegate: layout)
                }
            }
        }
    }
    
    private func showImagePicker(delegate:StandardLayout) {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: {
            image.delegate = delegate
        })
    }
    
    func checkPermission() -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    
                }
            })
            return checkPermission()
        case .restricted:
            userDidClickButton()
            return false
        case .denied:
            userDidClickButton()
            return false
        }
    }
    
    
    func userDidClickButton() {
        
        // initialise a pop up for using later
        let alertController = UIAlertController(title: "Permission denied", message: "Please go to Settings and turn on the permissions for Photo access.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        // check the permission status
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized.")
        case .notDetermined, .restricted, .denied:
            // redirect the users to settings
            self.present(alertController, animated: true, completion: nil)
        }
    }

    
}

