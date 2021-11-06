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
    var imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePickerController.delegate = self
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
    
    func showAlertFunction(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController  , animated: true, completion: nil)
        
    }

    @IBAction func photoOrCamaraPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.accessPhtotoLibrary()
        }
        
        let camaraAction = UIAlertAction(title: "Camara", style: .default) { (_) in
            self.accessCamara()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("You clicked cancel")
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(camaraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageView.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessPhtotoLibrary(){
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func accessCamara(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        }else {
            showAlertFunction(title: "Camara Not Available", message: "There is no camara available on this device")
        }
    }
}

