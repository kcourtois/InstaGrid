//
//  ViewController.swift
//  Instagrid
//
//  Created by Kévin Courtois on 05/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit
import Photos

class MainVC: UIViewController {

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
        
        //Sets view to layout 1
        setLayout(layout: .Layout1)
        
        //Create swipe gesture recognizer
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeExport(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeExport(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    //Selector for swipe gestures to export images
    @objc private func swipeExport(_ sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case .up:
            if UIDevice.current.orientation.isPortrait {
                imgGridUp()
            }
        case .left:
            if UIDevice.current.orientation.isLandscape {
                imgGridLeft()
            }
        default:
            break
        }
    }
    
    //Animation for the imageGrid, goes up and calls export
    private func imgGridUp() {
        UIView.animate(withDuration: 1) {
            self.imageGridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }
        exportImgGrid()
    }
    
    //Animation for the imageGrid, goes left and calls export
    private func imgGridLeft() {
        UIView.animate(withDuration: 1) {
            self.imageGridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        }
        exportImgGrid()
    }
    
    //Animates imageGrid back to it's initial position. Handles rotation to have a coherent anim.
    private func imgGridAnimCenter() {
        if UIDevice.current.orientation.isLandscape {
            self.imageGridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        } else {
            self.imageGridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }
        UIView.animate(withDuration: 1) {
            self.imageGridView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    //Present view to user for image share
    private func exportImgGrid() {
        let items = [getImgGridAsImage()]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.completionWithItemsHandler = { activity, completed, items, error in
            if !completed {
                self.presentShareFailedAlert()
            }
            else{
                self.presentShareSuccessAlert()
            }
            self.imgGridAnimCenter()
        }
        
        self.present(ac, animated: true, completion: nil)
        present(ac, animated: true)
    }
    
    //Alert for share success
    private func presentShareSuccessAlert() {
        //Initialisation of the alert
        let alertController = UIAlertController(title: "Share succeeded", message: "Image was shared successfully !", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        //Shows alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Alert for share fail
    private func presentShareFailedAlert() {
        //Initialisation of the alert
        let alertController = UIAlertController(title: "Share failed", message: "We were not able to share the image.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        //Shows alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Convert imgGrid to an image
    private func getImgGridAsImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageGridView.bounds.size)
        let image = renderer.image { ctx in
            imageGridView.drawHierarchy(in: imageGridView.bounds, afterScreenUpdates: true)
        }
        return image
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
    
    //Present an UIImagePickerController
    private func showImagePicker(delegate:StandardLayout) {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: {
            image.delegate = delegate
        })
    }
    
    //Check photo library permission
    private func checkPermission() -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in }
            return checkPermission()
        case .restricted:
            presentPermissionDeniedAlert()
            return false
        case .denied:
            presentPermissionDeniedAlert()
            return false
        }
    }
    
    //Shows a popup to access settings if user denied photolibrary permission
    private func presentPermissionDeniedAlert() {
        //Initialisation of the alert
        let alertController = UIAlertController(title: "Permission denied", message: "Please go to Settings and turn on the permissions for Photo access.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        //Shows alert
        self.present(alertController, animated: true, completion: nil)
    }
}
