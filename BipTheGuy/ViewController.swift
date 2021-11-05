//
//  ViewController.swift
//  BipTheGuy
//
//  Created by Karl Bernhardt on 11/6/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var punchButtonPressed: UIButton!
    
    
    //Variables
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func playSound(name: String){
        
        if let sound = NSDataAsset(name: name){
            
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
                
            }catch{
                print("Error: \(error.localizedDescription). Could not initialize AVaudioPlayer object")
            }
        }else {
            print("ERROR: Could not read data from file \(name)")
        }
        
    }

    @IBAction func punchButtonPressed(_ sender: UIButton) {
        
        let originalFrame = imageView.frame
        let shrinkSizeX: CGFloat = 20.0
        let shrinkSizeY: CGFloat = 30.0
        let smallerFrame = CGRect(x: imageView.frame.origin.x + shrinkSizeX,
                                  y: imageView.frame.origin.y + shrinkSizeY,
                                  width: imageView.frame.width - (2*shrinkSizeX),
                                  height: imageView.frame.height - (2*shrinkSizeY))
        
        playSound(name: "punchSound")
        imageView.frame = smallerFrame
        UIView.animate(withDuration: 3, delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options:[.curveLinear],
                       animations: {
            
                        self.imageView.frame = originalFrame
        },
                       completion: nil)
        
    }
    
    
    
    

}

