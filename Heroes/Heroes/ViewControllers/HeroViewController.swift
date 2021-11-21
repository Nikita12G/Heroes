//
//  HeroViewController.swift
//  Heroes
//
//  Created by Никита Гуляев on 18.11.2021.
//

import UIKit

class HeroViewController: UIViewController {
    
    var hero: HeroData?
    var selectedHeroArray : [String]?
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var attributePicker: UIPickerView!
    @IBOutlet weak var attributeLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = hero?.localized_name
        ImageHero()
        attributePicker.delegate = self
        attributePicker.dataSource = self
    }
    
    private func ImageHero() {
        
        let url = "https://api.opendota.com"+(hero?.img ?? "")
        guard let urlString = URL(string: url) else { return }
        heroImage.downloaded(from: urlString)
    }
    
    @IBAction func randomButton(_ sender: Any) {
        
    }
    
    @IBAction func selectedHeroButton(_ sender: Any) {
        
    }
}

//MARK: - UIPickerView
extension HeroViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return attributeHero.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return attributeHero[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        attributeLabel.text = attributeHero[row]
        attributeLabel.resignFirstResponder()
    }

}
