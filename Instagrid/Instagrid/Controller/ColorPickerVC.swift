//
//  colorPickerVC.swift
//  Instagrid
//
//  Created by Kévin Courtois on 14/03/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let colors = [#colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.2096434534, green: 0.948813498, blue: 0.8288460374, alpha: 1), #colorLiteral(red: 0.9323254228, green: 0.633320272, blue: 0.954120934, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 0, green: 0.7580425143, blue: 0.1413846612, alpha: 1)]
    private var selectedColor = #colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)

    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.layer.cornerRadius = 10
        self.pickerView.layer.masksToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = colors[indexPath.item]
    }
    
    @IBAction func closePopUp() {
        if let presenter = presentingViewController as? MainVC {
            if let contentView = presenter.imageGridView.viewWithTag(400){
                contentView.backgroundColor = selectedColor
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
