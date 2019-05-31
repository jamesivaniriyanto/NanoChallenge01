//
//  ViewController.swift
//  NanoChallenge01
//
//  Created by James Ivan Iriyanto on 26/05/19.
//  Copyright © 2019 James Ivan Iriyanto. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var viewlove: UIView!
    
    var imagePicker = UIImagePickerController()
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var ImagePick: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //emitter
        let snowView = SKView()
        snowView.frame = viewlove.frame
        snowView.allowsTransparency = true
        snowView.backgroundColor = UIColor.clear
        
        let snowScene = SKScene(size: viewlove.frame.size)
        snowScene.scaleMode = .aspectFill
        snowScene.backgroundColor = UIColor.clear
        
        let snowParticle = SKSpriteNode(fileNamed: "MyParticle.sks")
        snowParticle?.position = CGPoint(x: view.frame.width/2, y: viewlove.frame.height)
        
        
        snowScene.addChild(snowParticle!)
        snowView.presentScene(snowScene)
        viewlove.addSubview(snowView)
        viewlove.sendSubviewToBack(snowView)
        
        //music from  https://www.bensound.com
        do{
            let audioPath = Bundle.main.path(forResource: "piano", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!)as URL)
            
            let instance = AVAudioSession.sharedInstance()
            do{
                try instance.setCategory(.playback)
            }catch{
                //process Error
                print(error)
            }
        }catch{
            //Process Error
            print(error)
        }
        audioPlayer.play()
    }
    
    
    @IBAction func pickimage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: " ", message: "Photo Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else {
                print("Camera is not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action : UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        ImagePick.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   
    
}

