//
//  ViewController.swift
//  EAPicker
//
//  Created by Emre AYDIN on 01/17/2020.
//  Copyright (c) 2020 Emre AYDIN. All rights reserved.
//

import UIKit
import EAPicker

class ViewController: UIViewController {
    
    @IBOutlet weak var picker: EAPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        picker.setTitle("Title")
        picker.values = ["Value 1", "Value 2", "Value 3"]
        picker.selectedRow = 1

        picker.titleLabelColor = .red
        picker.titleLabelFont = UIFont.boldSystemFont(ofSize: 20)

        picker.valueLabelColor = .blue
        picker.valueLabelFont = UIFont.systemFont(ofSize: 23)
    }

}

extension ViewController: EAPickerDelegate {
    
    func didSelectRow(_ pickerView: EAPicker, didSelectRow row: Int) {
        print("************* didSelectRow", row)
    }
    
    func doneButtonPressed(_ pickerView: EAPicker, didSelectRow row: Int) {
        print("************* doneButtonPressed", row)
    }
    
}

