//
//  ViewController.swift
//  SliderColorTwo
//
//  Created by Игорь Сысоев on 03.09.2021.
//

import UIKit
protocol UpdateColorDeligate {
    func updateColorView (red: CGFloat, green: CGFloat, blue: CGFloat)
}
class MainScreenViewController: UIViewController {

    @IBOutlet weak var mainScreenView: UIView!
    
    private var red:CGFloat = 1.0
    private var green:CGFloat = 1.0
    private var blue:CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SettingsColorVC = segue.destination as? SettingsColorViewController else { return }
        SettingsColorVC.colorMainView = mainScreenView.backgroundColor
        SettingsColorVC.deligate = self
    }

    private func updateView() {
        mainScreenView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

extension MainScreenViewController: UpdateColorDeligate {
    func updateColorView(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        updateView()
    }
    
    
    
}

