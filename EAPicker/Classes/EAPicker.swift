//
//  EAPicker.swift
//  EAPicker
//
//  Created by Emre AYDIN on 17.01.2020.
//  Copyright © 2020 Emre AYDIN. All rights reserved.
//

import UIKit

public protocol EAPickerDelegate {
    func didSelectRow(_ pickerView: EAPicker, didSelectRow row: Int)
    func doneButtonPressed(_ pickerView: EAPicker, didSelectRow row: Int)
}

public class EAPicker: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var arrowButton: UIButton!
    
    public var delegate: EAPickerDelegate?
    
    /// values: String list of picker values
    public var values: [String]! {
        didSet {
            if let values = values, values.count > 0 {
                setValue(values[0])
            }
        }
    }
    
    /// selectedRow: Currently selected row
    public var selectedRow = 0 {
        didSet {
            if let values = values, selectedRow > 0, selectedRow < values.count {
                pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
                setValue(values[selectedRow])
            }
        }
    }
    
    /// setEnabled: Picker can be enabled or disabled
    public func setEnabled(_ isEnabled: Bool) {
        self.isUserInteractionEnabled = isEnabled
        if isEnabled {
            setViewColors(valueLabelColor)
        } else {
            setViewColors(.gray)
        }
    }
    
    /// isTitleHidden: Title visibility
    public var isTitleHidden = false {
        didSet {
            titleLabel.isHidden = isTitleHidden
        }
    }
    
    /// setTitle: Set the title
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    /// messageLabelColor: Color of message label
    public var titleLabelColor = UIColor.darkGray {
        didSet {
            titleLabel.textColor = titleLabelColor
        }
    }
    
    /// messageLabelFont: Font of message label
    public var titleLabelFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            titleLabel.font = titleLabelFont
        }
    }
    
    /// messageLabelColor: Color of message label
    public var valueLabelColor = UIColor(red: 43/255.0, green: 37/255.0, blue: 72/255.0, alpha: 1) {
        didSet {
            setViewColors(valueLabelColor)
        }
    }
    
    /// messageLabelFont: Font of message label
    public var valueLabelFont = UIFont.systemFont(ofSize: 23) {
        didSet {
            button.titleLabel?.font = valueLabelFont
        }
    }
    
    private var pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var doneButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Default height: 60
    private func commonInit() {
        let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let doneButtonWidth: CGFloat = 66
        let screenWidth = UIScreen.main.bounds.width
        
        Bundle(for: EAPicker.self).loadNibNamed("EAPicker", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = transparentColor
        self.backgroundColor = transparentColor
        
        titleLabel.textColor = titleLabelColor
        titleLabel.font = titleLabelFont
        
        arrowButton.setImage(UIImage(named: "arrow-down", in: Bundle(for: EAPicker.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        doneButton = UIButton(frame: CGRect(x: screenWidth-doneButtonWidth, y: 0, width: doneButtonWidth, height: 50))
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(pickerDone), for: .touchUpInside)
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 240))
        inputView.addSubview(pickerView)
        inputView.addSubview(doneButton)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalTo: inputView.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: inputView.centerYAnchor).isActive = true
        textField.inputView = inputView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setViewColors(valueLabelColor)
    }
    
    @IBAction func button(_ sender: UIButton) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func arrowButton(_ sender: UIButton) {
        textField.becomeFirstResponder()
    }
    
    @objc func pickerDone() {
        if selectedRow < values.count {
            setValue(values[selectedRow])
            delegate?.doneButtonPressed(self, didSelectRow: selectedRow)
        }
        textField.resignFirstResponder()
    }
    
    private func setValue(_ title: String) {
        button.setTitle(title, for: .normal)
    }
    
    private func setViewColors(_ color: UIColor) {
        button.setTitleColor(color, for: .normal)
        doneButton.setTitleColor(color, for: .normal)
        arrowButton.tintColor = color
    }

}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension EAPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        setValue(values[row])
        delegate?.didSelectRow(self, didSelectRow: row)
    }
    
}

