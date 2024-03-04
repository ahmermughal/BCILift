//
//  InstructionsVC.swift
//  BCILift
//
//  Created by Ahmer Mughal on 21.02.24.
//

import UIKit
import AVFoundation

enum LiftStep {
    
    case speakActiveBCI
    case activateBCI
    case speakCallLift
    case callLift
    case speakLiftIsComing
    case speakSelectFloor
    case selectFloor
    case speakFloorSelected
    case speakCloseDoor
    case speakDeactivateBCI
    case deactivateBCI
    
    case closeDoor
    case completed
    
}

class InstructionsVC: BaseViewController {
    
    private let contentView = InstructionsContentView()
    
    private let museManager : MuseManager
    
    private var currentStep : LiftStep = .activateBCI
    
    private var blinkCounter = 0
    
    private var jawClenchCounter = 0
    
    private var bciActivated = false
    
    private var floorSelectionTimer : Timer?
    
    private var synthesizer = AVSpeechSynthesizer()
    
    
    init(museManager: MuseManager) {
        self.museManager = museManager
        super.init(nibName: nil, bundle: nil)
        museManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Functions
    /// Loads the content view as the parent view of the view controller
    override func loadView() {
        self.view = contentView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contentView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        synthesizer.delegate = self
        contentView.button.isHidden = true

        // Do any additional setup after loading the view.
        setupActivateBCI()

    }
    
    
    @objc private func buttonTapped(){
        
        blinkCounter = 0
        jawClenchCounter = 0
        bciActivated = false
        currentStep = .activateBCI
        setupActivateBCI()
        contentView.button.isHidden = true
        
    }
    
    private func setupActivateBCI(){
        
        let instruction = "Blink 4 times to activate BCI."
        contentView.instructionsLabel.text = "1. \(instruction)"
        currentStep = .speakActiveBCI
        speakTheFollowing(sentence: instruction)
        
    }
    
    private func setupCallLift(){
        let instruction = "Focus to call lift."
        contentView.instructionsLabel.text = "2. Focus to call lift."
        currentStep = .speakCallLift
        speakTheFollowing(sentence: instruction)
        
    }
    
    private func setupLiftIsComing(){
        let instruction = "Lift is coming to you."
        currentStep = .speakLiftIsComing
        speakTheFollowing(sentence: instruction)

    }
    
    private func setupSelectFloor(){
        let instruction = "Blink to select floor."
        contentView.instructionsLabel.text = "3. Blink to select floor."
        currentStep = .speakSelectFloor
        speakTheFollowing(sentence: instruction)
        
    }
    
    private func setupDeactivateBCI(){
        let instruction = "Clench Jaw 2 times to deactivate BCI."
        contentView.instructionsLabel.text = "4. \(instruction)"
        currentStep = .speakDeactivateBCI
        speakTheFollowing(sentence: instruction)
    }
    
    private func setupDoneDeactivateBCI(){
        let instruction = "BCI deactivated"
        contentView.instructionsLabel.text = "\(instruction)."
        contentView.button.isHidden = false
        speakTheFollowing(sentence: instruction)
    }
    
    private func setupDoorClose(){
        let instruction = "Clench Jaw 2 times to close door."
        contentView.instructionsLabel.text = "4. Clench Jaw 2 times to close door."
        currentStep = .speakCloseDoor
        speakTheFollowing(sentence: instruction)
    }
    
    private func setupCompleted(){
        let instruction = "Completed"
        contentView.instructionsLabel.text = "5. Completed"
        speakTheFollowing(sentence: instruction)
    }
    
    private func speakTheFollowing(sentence: String){
        
        let utterence = AVSpeechUtterance(string: sentence)
        utterence.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterence.rate = 0.3
        
        synthesizer.speak(utterence)
        
    }
    
    private func floorSelectTimerCalled(timer : Timer){
        let selectedFloor = blinkCounter - 2
        let utterence = AVSpeechUtterance(string: "Floor number \(selectedFloor) selected")
        utterence.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterence.rate = 0.3
        
        currentStep = .speakFloorSelected
        
        synthesizer.speak(utterence)
        
        // Call floor select api
        
        
        
    }
    
    private func callGoToFloorAPI(){
        let selectedFloor = blinkCounter - 2

        print("Selected Floor is \(selectedFloor)")
        
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        
        NetworkManager.shared.goToFloor(floorNumber: selectedFloor) { result in
            switch result {
            case .success(let success):
                print(success)
                
            case .failure(let failure):
                print(failure)
            }
            
            DispatchQueue.main.async {
                self.dismissLoadingView()
                // Add API to check if
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                   // self.setupCompleted()//self.setupDoorClose()
                    self.setupDeactivateBCI()
                }
            }
        }
    }
    
}


extension InstructionsVC : MuseManagerDelegate {
    
    
    func blinkDetected() {
        
        if currentStep == .activateBCI{
            
            if blinkCounter < 4{
                blinkCounter += 1
            } else {
                if !bciActivated {
                    bciActivated = true
                    blinkCounter = 0
                    setupCallLift()
                }
            }
        }else if currentStep == .selectFloor {
            
            if blinkCounter == 0 {
                floorSelectionTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: floorSelectTimerCalled)
                blinkCounter += 1
                print("Blink Counts = \(blinkCounter)")
            }else if blinkCounter < 4{
                blinkCounter += 1
                print("Blink Counts = \(blinkCounter)")

            }
            
        }
        
    }
    
    func jawClenchDetected() {
        
        if currentStep == .deactivateBCI{
            
            if jawClenchCounter < 2{
                jawClenchCounter += 1
            }else {
                // call close door API
                currentStep = .completed
                setupDoneDeactivateBCI()
            }
            
        }
        
    }
    
    func callLift() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        // run call Lift API here
        NetworkManager.shared.callLift { result in
            switch result {
            case .success(let success):
                print(success)
                
            case .failure(let failure):
                
                print(failure)
            }
            DispatchQueue.main.async {
                self.dismissLoadingView()
                self.setupLiftIsComing()
                
            }
            
        }
        
    }
    
    
}


extension InstructionsVC : AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        switch currentStep{
        case .speakActiveBCI:
            print("Done speaking activate")
            currentStep = .activateBCI
            break
        case .speakCallLift:
            currentStep = .callLift
            museManager.listenToBetaValues = true
        case .speakLiftIsComing:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.setupSelectFloor()
            }
        case .speakSelectFloor:
            self.currentStep = .selectFloor
        case .speakFloorSelected:
            callGoToFloorAPI()
        case .speakDeactivateBCI:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.currentStep = .deactivateBCI
            }
        case .speakCloseDoor:
            self.currentStep = .closeDoor
        case .completed:
            break
        default:
            break
        }
        
    }
    
}
