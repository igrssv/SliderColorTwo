//
//  SettingsColorViewController.swift
//  SliderColorTwo
//
//  Created by Игорь Сысоев on 03.09.2021.
//

import UIKit

class SettingsColorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var setColorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet var sliderCollection: [UISlider]!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    private var red:CGFloat = 0.0
    private var green:CGFloat = 0.0
    private var blue:CGFloat = 0.0
    private var alpha:CGFloat = 0.0
    
    var colorMainView:UIColor!
    var deligate: UpdateColorDeligate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        startValuesUpdate()
        createTollBar()
    }
    
    //MARK: - Action
    @IBAction func sliderColor(_ sender: UISlider) {
        updateValuesSlider(sender: sender)
    }
    
    @IBAction func donePressButton() {
        deligate.updateColorView(red: red, green: green, blue: blue)
        dismiss(animated: true)
    }

}

//MARK: - Update
extension SettingsColorViewController {
    private func startValuesUpdate() {
        setColorView.layer.cornerRadius = 10
        setColorView.backgroundColor = colorMainView
        _ = setColorView.backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        updateLableAndView()
        
        sliderCollection[0].value = Float(red)
        sliderCollection[1].value = Float(blue)
        sliderCollection[2].value = Float(blue)
    }
    
    private func updateValuesSlider(sender: UISlider) {
        switch sender.tag{
        case 0:
            red = CGFloat(sliderCollection[0].value)
        case 1:
            green = CGFloat(sliderCollection[1].value)

        default:
            blue = CGFloat(sliderCollection[2].value)
        }
        updateLableAndView()
    }
    @objc private func updateValuesSlidetInTextField() {
        view.endEditing(true)
        sliderCollection[0].value = Float(red)
        sliderCollection[1].value = Float(green)
        sliderCollection[2].value = Float(blue)
        updateLableAndView()
    }
    private func updateLableAndView() {
        redValueLabel.text = String(format: "%.2f", red)
        greenValueLabel.text = String(format: "%.2f", green)
        blueValueLabel.text = String(format: "%.2f", blue)
        
        redTF.text = String(format: "%.2f", red)
        greenTF.text = String(format: "%.2f", green)
        blueTF.text = String(format: "%.2f", blue)

        setColorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}


//MARK: - TextField
extension SettingsColorViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == redTF {
            guard let value = NumberFormatter().number(from: textField.text ?? "") as? CGFloat else {return}
            red = value
            updateValuesSlidetInTextField()
        }else if textField == greenTF {
            guard let value = NumberFormatter().number(from: textField.text ?? "") as? CGFloat else {return}
            green = value
            updateValuesSlidetInTextField()
        }else {
            guard let value = NumberFormatter().number(from: textField.text ?? "") as? CGFloat else {return}
            blue = value
            updateValuesSlidetInTextField()
        }
    }
}

//MARK: - Add TollBar
extension SettingsColorViewController {
    private func createTollBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.height))
        let toolBarSpasing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                             target: self,
                                             action: nil)
        let doneItem = UIBarButtonItem(title: "Done",
                                       style: .done,
                                       target: nil,
                                       action: #selector(updateValuesSlidetInTextField))
        toolBar.items = [toolBarSpasing, doneItem]
        toolBar.sizeToFit()
        redTF.inputAccessoryView = toolBar
        greenTF.inputAccessoryView = toolBar
        blueTF.inputAccessoryView = toolBar
       
    }

}
