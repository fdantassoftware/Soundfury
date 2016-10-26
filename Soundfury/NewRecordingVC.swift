//
//  NewRecordingVC.swift
//  Soundfury
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import UIKit
import AVFoundation

class NewRecordingVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var savePressed: UIButton!
    @IBOutlet weak var waveIMG: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var playBT: UIButton!
    @IBOutlet weak var recordBT: UIButton!
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioURL: URL?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        savePressed.layer.cornerRadius = 5.0
        savePressed.clipsToBounds = true
        setupRecorder()
        playBT.isEnabled = false
        savePressed.isEnabled = false
     
    }
    
    func setupRecorder() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
        
            let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponentes = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponentes)!
        
            var settings: [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject!
            settings[AVSampleRateKey] = 44100.0 as AnyObject!
            settings[AVNumberOfChannelsKey] = 2 as AnyObject!
            
         
            
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
 
    @IBAction func recordpressed(_ sender: AnyObject) {
        if audioRecorder!.isRecording {
            let btImage = UIImage(named: "startrecording.png")
            audioRecorder!.stop()
            recordBT.setImage(btImage, for: .normal)
            playBT.isEnabled = true
            savePressed.isEnabled = true
            waveIMG.image = UIImage(named: "wave.png")
            
            
            
        } else {
            audioRecorder!.record()
            let btImage = UIImage(named: "stoprecording.png")
            recordBT.setImage(btImage, for: .normal)
        }
    }

    @IBAction func playPressed(_ sender: AnyObject) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        
        }catch let error as NSError {
            print(error)
            
        }
        
    }
  
    @IBAction func savePressed(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sound = Sound(context: context)
        if let name = nameLabel.text {
            sound.name = name
            sound.audio = NSData(contentsOf: audioURL!)
            let ad = UIApplication.shared.delegate as! AppDelegate
            ad.saveContext()
            dismiss(animated: true, completion: nil)
        }

    }
    
    @IBAction func backPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameLabel.resignFirstResponder()
        return true
    }
    
    
}
