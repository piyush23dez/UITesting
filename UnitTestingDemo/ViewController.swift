//
//  ViewController.swift
//  UnitTestingDemo
//
//  Created by Piyush on 8/21/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var numberSLider: UISlider!
    @IBOutlet weak var percentSlider: UISlider!
    
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var number: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberSliderChanged(_ sender: AnyObject) {
        numberSLider.setValue(sender.value, animated: true)
        let resultVal = getPercentage(sender.value, percentSlider.value)
        updateLabels(sender.value, percentvalue: nil, resultValue: resultVal)
        
    }

    @IBAction func percentSliderChanged(_ sender: AnyObject) {

        percentSlider.setValue(sender.value, animated: true)
        let resultVal = getPercentage(numberSLider.value, sender.value)
        updateLabels(nil, percentvalue: sender.value, resultValue: resultVal)

    }
    
    func updateLabels(_ numberValue: Float?,percentvalue: Float?, resultValue: Float?) {
        if let num = numberValue {
            number.text = "\(num)"
        }
        
        if let perc  = percentvalue {
            percent.text = "\(perc)%"
        }
        

        result.text = "\(resultValue!)"
        
        
        
    }
    
    func getPercentage(_ value: Float,_ percentage: Float) -> Float {
        return value * (percentage/100)
    }
}

