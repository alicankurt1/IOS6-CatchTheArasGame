//
//  ViewController.swift
//  CatchTheAras
//
//  Created by Alican Kurt on 8.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var arasView0: UIImageView!
    @IBOutlet weak var arasView1: UIImageView!
    @IBOutlet weak var arasView2: UIImageView!
    @IBOutlet weak var arasView3: UIImageView!
    @IBOutlet weak var arasView4: UIImageView!
    @IBOutlet weak var arasView5: UIImageView!
    @IBOutlet weak var arasView6: UIImageView!
    @IBOutlet weak var arasView7: UIImageView!
    @IBOutlet weak var arasView8: UIImageView!
    @IBOutlet weak var arasView9: UIImageView!
    @IBOutlet weak var arasView10: UIImageView!
    @IBOutlet weak var arasView11: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var timer = Timer()
    var counter = 20
    var randomNumber = 0
    var score = 0
    var bestScore = 0
    var imageViewArray: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Appending image Views in imageView Array
        
        imageViewArray.append(contentsOf: [arasView0,arasView1,arasView2,arasView3,arasView4,arasView5,arasView6,arasView7,arasView8,arasView9,arasView10,arasView11])
        
        //imageViewArray[0].isHidden = false
        
        let gestureRecognizer0 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer10 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        let gestureRecognizer11 = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        
        var gestureRecognizerArray: [UITapGestureRecognizer] = []
        gestureRecognizerArray.append(contentsOf: [gestureRecognizer0,gestureRecognizer1,gestureRecognizer2,gestureRecognizer3,gestureRecognizer4,gestureRecognizer5,gestureRecognizer6,gestureRecognizer7,gestureRecognizer8,gestureRecognizer9,gestureRecognizer10,gestureRecognizer11])
        
        for i in 0...11 {
            imageViewArray[i].isUserInteractionEnabled = true
            imageViewArray[i].addGestureRecognizer(gestureRecognizerArray[i])
        }
        
        let storedScore = UserDefaults.standard.object(forKey: "bestScore")
        if (storedScore as? Int) != nil {
            bestScore = storedScore as! Int
            highScoreLabel.text = "High Score: \(bestScore)"
        }
        

    }
    
    // Start Button
    @IBAction func startGameClick(_ sender: Any) {
        startGame()
    }
    // Start Game and Timer
    func startGame(){
        counter = 20
        score = 0
        currentScoreLabel.text = "Score: 0"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(startTime), userInfo: nil, repeats: true)
    }
    
    // Timer selector Function
    @objc func startTime(){
        
        imageViewArray[randomNumber].isHidden = true
                       
        if counter != 0{
            timeLabel.text = "Time: \(counter/2)"
            counter -= 1
            randomNumber = Int.random(in: 0..<12)
            imageViewArray[randomNumber].isHidden = false
        }else{
            // after game over
            timer.invalidate()
            timeLabel.text = "Over!"
            if score > bestScore{
                bestScore = score
                UserDefaults.standard.setValue(score, forKey: "bestScore")
                highScoreLabel.text = "High Score: \(bestScore)"
                showAlert(title: "Congratulations!",message: "Break a Record! New Best Score is: \(score)")
            }else{
                showAlert(title: "Time is Up!", message: "Try Again..")
            }
            
        }
        
    }
    
    // Image Views Tapped Function
    @objc func tappedImageView(){
        score += 1
        currentScoreLabel.text = "Score: \(score)"
    }
    
    // Show Alert after end of game
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let againButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { _ in
            self.startGame()
        }
        
        alert.addAction(okButton)
        alert.addAction(againButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

