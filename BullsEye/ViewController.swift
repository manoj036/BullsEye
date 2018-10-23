//
//  ViewController.swift
//  BullsEye
//
//  Created by manoj.gubba on 2018/10/19.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedValue = slider.value.rounded()
        currentValue=Int(roundedValue)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }

    @IBAction func showAlert() {
        let message = "The value of slider is now: \(currentValue)"
        let difference = abs(currentValue-targetValue)
        let points:Int
        let title: String
        
        if(difference == 0){
            title="Perfect"
            points = 200
        }else if(difference<5){
            title="You almost had it"
            points = 150-difference
        }else if(difference<10){
            title="Pretty Good"
            points = 100-difference
        }else{
            title="Not even close"
            points = 100-difference
        }
        score += points
        
        let alert = UIAlertController(title: "you scored \(points)", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: title, style: .default, handler: {
        action in
        self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func startOver(){
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue=Int(roundedValue)
    }
    
    func startNewRound() {
        round += 1
        targetValue=Int.random(in: 1...100)
        currentValue = 50
        slider.value=Float(currentValue)
        updateLabel()
    }
    
    func updateLabel() {
        scoreLabel.text=String(score)
        targetLabel.text=String(targetValue)
        roundLabel.text=String(round)
    }
}

