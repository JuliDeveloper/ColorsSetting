//
//  ViewController.swift
//  ColorsSetting
//
//  Created by Julia Romanenko on 06.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var areaOfView: UIView!
    @IBOutlet var lableRedColor: UILabel!
    @IBOutlet var lableGreenColor: UILabel!
    @IBOutlet var lableBlueColor: UILabel!
    @IBOutlet var sliderRedColor: UISlider!
    @IBOutlet var sliderGreenColor: UISlider!
    @IBOutlet var sliderBlueColor: UISlider!
    
    private let maxAlpha: CGFloat = 1
    private let minValueSlider: Float = 0
    private let maxValueSlider: Float = 1
    private let contraction = "%.2f"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSettingView()
        
        setSettingSlider(sliderRedColor,
                         0.05,
                         minValueSlider,
                         maxValueSlider,
                         .red)
        
        setSettingSlider(sliderGreenColor,
                         0.25,
                         minValueSlider,
                         maxValueSlider,
                         .green)
        
        setSettingSlider(sliderBlueColor,
                         0.45,
                         minValueSlider,
                         maxValueSlider,
                         .blue)

        lableRedColor.text = String(sliderRedColor.value)
        lableGreenColor.text = String(sliderGreenColor.value)
        lableBlueColor.text = String(sliderBlueColor.value)
    }

    @IBAction func actionRedColor() {
        lableRedColor.text = String(format: contraction, sliderRedColor.value)
        paintedBackgroundView()
    }
    
    @IBAction func actionGreenColor() {
        lableGreenColor.text = String(format: contraction, sliderGreenColor.value)
        paintedBackgroundView()
    }
    
    @IBAction func actionBlueColor() {
        lableBlueColor.text = String(format: contraction, sliderBlueColor.value)
        paintedBackgroundView()
    }
}

//MARK: Private methods
extension ViewController {
    
    private func setSettingView() -> Void {
        areaOfView.alpha = 0.3
        areaOfView.layer.cornerRadius = 20
        areaOfView.backgroundColor = .black
    }
    
    private func setSettingSlider(_ slider: UISlider,
                                  _ value: Float,
                                  _ minValue: Float,
                                  _ maxValue: Float,
                                  _ trackColor: UIColor) -> Void {
        slider.value = value
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.minimumTrackTintColor = trackColor
    }
    
    private func paintedBackgroundView() {
        areaOfView.alpha = maxAlpha
        areaOfView.backgroundColor = UIColor.init(
            red: CGFloat(sliderRedColor.value),
            green: CGFloat(sliderGreenColor.value),
            blue: CGFloat(sliderBlueColor.value),
            alpha: maxAlpha
        )
    }
}
