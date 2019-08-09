import UIKit
import AudioToolbox
import AVFoundation

class SoundPlayVC: UIViewController {

    @IBOutlet var func1Button: UIButton! { didSet { func1Button.tag = 0 } }
    @IBOutlet var func2Button: UIButton! { didSet { func2Button.tag = 1 } }
    @IBOutlet var func3Button: UIButton! { didSet { func3Button.tag = 2 } }
    @IBOutlet var func4Button: UIButton! { didSet { func4Button.tag = 3 } }
    
    var vibTimer = Timer()
    var timerRuning = false
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func buttonPushAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: function1()
        case 1: function2()
        case 2: function3()
        case 3: function4()
        default:break
        }
    }
    
    ///////////////////////////////////////////////////////////////
    func function1(){
        if !timerRuning {
            timerRuning = true
            vibTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(vibAction), userInfo: nil, repeats: true)
        } else {
            timerRuning = false
            vibTimer.invalidate()
        }
    }
    
    func function2(){
        if let soundURL = Bundle.main.url(forResource: "piano2", withExtension: "wav") {
            var mySound: SystemSoundID = 114124874
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        } else {
            print("url !!!!")
        }
    }
    
    func function3(){
        print("호출")
        do {
            if let fileURL = Bundle.main.path(forResource: "piano2", ofType: "wav") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer?.numberOfLoops = -1
                let result0 = audioPlayer?.prepareToPlay()
                let result1 = audioPlayer?.play()
                print("\(String(describing: result0)) \(String(describing: result1))")
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
    }
    
    func function4(){
        
    }
    
    @objc func vibAction(){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
