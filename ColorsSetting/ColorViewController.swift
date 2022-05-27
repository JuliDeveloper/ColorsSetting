//
//  ColorViewController.swift
//  ColorsSetting
//
//  Created by Julia Romanenko on 03.05.2022.
//

import UIKit

protocol SettingColor {
    func setBackgroundColor(_ color: UIColor)
}

class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingColorViewController {
            settingVC.delegate = self
            settingVC.backgroundColor = view.backgroundColor
        }
    }
}

extension ColorViewController: SettingColor {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

