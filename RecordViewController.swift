//
//  RecordViewController.swift
//  pitch perfect
//
//  Created by pu yang on 1/19/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        
//        recordingLabel.text = "Recording in progress"
//        stop.isEnabled = true
//        record.isEnabled = false
//
//        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
//        let recordingName = "recordedVoice.wav"
//        let pathArray = [dirPath, recordingName]
//        let filePath = URL(string: pathArray.joined(separator: "/"))
//        print(filePath!)
//        let session = AVAudioSession.sharedInstance()
//        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
//
//        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
//        audioRecorder.delegate = self
//        audioRecorder.isMeteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
        
        recordingLabel.text="recording in progress"
        stop.isEnabled=true
        record.isEnabled=false
        
        let dirPath=NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
        
        let recordingName="recordedVoice.wav"
        let pathArray=[dirPath,recordingName]
        let filepath=NSURL.fileURL(withPathComponents: pathArray)
        print(filepath!)
        let session=AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder=AVAudioRecorder(url: filepath!,settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled=true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        
        record.isEnabled = true
        stop.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        
        let audiosession = AVAudioSession.sharedInstance()
        try! audiosession.setActive(false)
        
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "goToSecondScreen", sender: audioRecorder.url)
        }
        else {
            print("Voice not recorded")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            print("Recorded Audio Url: \(recordedAudioURL)")
        }
    }
    
}
