//
//  ViewController.swift
//  ColorsSetting
//
//  Created by Julia Romanenko on 06.04.2022.
//

import UIKit

class SettingColorViewController: UIViewController {

    @IBOutlet var areaOfView: UIView!
    
    @IBOutlet var lableRedColor: UILabel!
    @IBOutlet var lableGreenColor: UILabel!
    @IBOutlet var lableBlueColor: UILabel!
    
    @IBOutlet var sliderRedColor: UISlider!
    @IBOutlet var sliderGreenColor: UISlider!
    @IBOutlet var sliderBlueColor: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    var delegate: SettingColor!
    var backgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        areaOfView.layer.cornerRadius = 20
        areaOfView.backgroundColor = backgroundColor
        
        setSettingSlider(sliderRedColor, .red)
        setSettingSlider(sliderGreenColor, .green)
        setSettingSlider(sliderBlueColor, .blue)
        
        settingSliders()

        setValue(for: lableRedColor, lableGreenColor, lableBlueColor)
        setValue(for: redTextField, greenTextField, blueTextField)
        
        doneButton.layer.cornerRadius = 5
    }

    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender {
        case sliderRedColor:
            setValue(for: lableRedColor)
            setValue(for: redTextField)
        case sliderGreenColor:
            setValue(for: lableGreenColor)
            setValue(for: greenTextField)
        default:
            setValue(for: lableBlueColor)
            setValue(for: blueTextField)
        }
        
        paintedBackgroundView()
    }

    @IBAction func saveColor() {
        delegate.setBackgroundColor(areaOfView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

//MARK: Private methods
extension SettingColorViewController {
    
    private func paintedBackgroundView() {
        areaOfView.backgroundColor = UIColor(
            red: CGFloat(sliderRedColor.value),
            green: CGFloat(sliderGreenColor.value),
            blue: CGFloat(sliderBlueColor.value),
            alpha: 1
        )
    }
    
    private func settingSliders() {
        let color = CIColor(color: backgroundColor)
        
        sliderRedColor.value = Float(color.red)
        sliderGreenColor.value = Float(color.green)
        sliderBlueColor.value = Float(color.blue)
    }
    
    private func setSettingSlider(_ slider: UISlider, _ trackColor: UIColor) {
        slider.minimumTrackTintColor = trackColor
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for lables: UILabel...) {
        lables.forEach { lable in
            switch lable {
            case lableRedColor:
                lable.text = string(from: sliderRedColor)
            case lableGreenColor:
                lable.text = string(from: sliderGreenColor)
            default:
                lable.text = string(from: sliderBlueColor)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: sliderRedColor)
            case greenTextField:
                textField.text = string(from: sliderGreenColor)
            default:
                textField.text = string(from: sliderBlueColor)
            }
        }
    }
    
    private func createAlertController() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Введите верные значения от 0.00 до 1.00",
                                      preferredStyle: .alert)
        
        let buttonAlert = UIAlertAction(title: "OK",
                                        style: .default)
        
        alert.addAction(buttonAlert)
        present(alert, animated: true)
    }
    
    @objc func tapDoneToolBar() {
        view.endEditing(true)
    }
}


extension SettingColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        guard let number = Float(text) else { return }
        
        if number > Float(1) {
            textField.text = "1.00"
            createAlertController()
        }
        
        if let currentText = Float(text) {
            switch textField {
            case redTextField:
                sliderRedColor.setValue(currentText, animated: true)
                setValue(for: lableRedColor)
            case greenTextField:
                sliderGreenColor.setValue(currentText, animated: true)
                setValue(for: lableGreenColor)
            default:
                sliderBlueColor.setValue(currentText, animated: true)
                setValue(for: lableBlueColor)
            }
            paintedBackgroundView()
        } else if text == "" {
            createAlertController()
        }
            
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(tapDoneToolBar))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    
}
