//
//  MuseManager.swift
//  BCILift
//
//  Created by Ahmer Mughal on 22.02.24.
//

import Foundation
import CoreBluetooth

protocol MuseManagerDelegate {
    
    func museListUpdated()
    func blinkDetected()
    func jawClenchDetected()
    func museConnected()
    func callLift()
}

extension MuseManagerDelegate {
    func museListUpdated(){}
    func blinkDetected(){}
    func jawClenchDetected(){}
    func museConnected(){}
    func callLift(){}
}

class MuseManager : NSObject {
    
    var delegate : MuseManagerDelegate?
    
    private let museManager : IXNMuseManagerIos = IXNMuseManagerIos.sharedManager()
    private var selectedMuse : IXNMuse?
    
    private var lastBlink: Bool?
    private var lastJawClench: Bool?
    
    private var detectAgain = true
    
    private var logs : [String] = []
    
    private let bluetoothManager : CBCentralManager = CBCentralManager()
    private var btState : Bool = false
    
    var listenToBetaValues = false
    private var valueAchivedToTriggerBCI = false
    
    private var betaValueTimer : Timer?
    
    private var isDeviceConnectedBefore = false
    
    override init() {
        super.init()
        museManager.museListener = self

    }
    
    var availableMuseDevices : [IXNMuse] {
        return museManager.getMuses()
    }
    
    
    func startScanning(){
        museManager.startListening()
    }
    
    func stopScanning(){
        museManager.stopListening()
    }
    
    func connect(to muse: IXNMuse){
                
        selectedMuse?.disconnect()
        selectedMuse = muse
        connectMuse()
    }
    
    private func connectMuse(){
        if let selectedMuse {
            
            // Setup listening to connection state
            selectedMuse.register(self)
            
            
            selectedMuse.register(self, type: .artifacts)
            
            selectedMuse.register(self, type: .betaAbsolute)
            
            selectedMuse.runAsynchronously()
        }
    }
    
    
    func logMuse(str: String){
        logs.insert(str, at: 0)
        
        DispatchQueue.main.async {
            //self.contentView.textView.text = self.logs.joined(separator: "\n")
        }
    }
    
    
    private func configureMuseManager(){
        museManager.museListener = self
    }
    
    private func configureBluetoothManager(){
        
        bluetoothManager.delegate = self
        
    }
    
    private func configureLogManager(){
        IXNLogManager.instance()?.setLogListener(self)
    }
    
}


extension MuseManager : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        btState = central.state == .poweredOn ? true : false
        
    }
    
    
}


// MARK:- MUSE Callbacks

extension MuseManager : IXNMuseListener, IXNMuseConnectionListener, IXNMuseDataListener, IXNLogListener {
    
    
    func receive(_ packet: IXNMuseDataPacket?, muse: IXNMuse?) {
        
        if packet?.packetType() == .betaAbsolute{
            
            let valueOne = packet?.values()[IXNEeg.EEG1.rawValue].doubleValue ?? 0.0
            let valueTwo = packet?.values()[IXNEeg.EEG2.rawValue].doubleValue ?? 0.0
            let valueThree = packet?.values()[IXNEeg.EEG3.rawValue].doubleValue ?? 0.0
            let valueFour = packet?.values()[IXNEeg.EEG4.rawValue].doubleValue ?? 0.0

            let betaValStr =  String(format: "%5.2f %5.2f %5.2f %5.2f", valueOne,
                                      valueTwo,
                                      valueThree,
                                      valueFour)
            if listenToBetaValues{
                if valueOne <= 0.5 && valueOne > 0.1 {
//                    if betaValueTimer == nil {
//                        betaValueTimer = Timer(timeInterval: 0.5, repeats: false, block: { _ in
//                            self.delegate?.callLift()
//                            self.listenToBetaValues = false
//                        })
//                    }
                    self.delegate?.callLift()
                    self.listenToBetaValues = false
                    
                } else {
                    
                    betaValueTimer?.invalidate()
                    betaValueTimer = nil
                }
            }
                print(betaValStr)
                logMuse(str: betaValStr)
        }
        
    }
    
    
    
    func receive(_ packet: IXNMuseArtifactPacket, muse: IXNMuse?) {
        
        
        // if detectAgain {
        
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1){
        
        //    self.detectAgain = false
        
        
        
        //}
        
        
        if packet.blink && packet.blink != lastBlink {
            print("Blink Detected: \(packet.blink)")
            logMuse(str: "Blink Detected: \(packet.blink)")
            delegate?.blinkDetected()
            
        } else if packet.jawClench && packet.jawClench != self.lastJawClench {
            print("Jaw Clench Detected: \(packet.jawClench)")
            logMuse(str: "Jaw Clench Detected: \(packet.jawClench)")
            delegate?.jawClenchDetected()
        }
        
        
        
        self.lastBlink = packet.blink
        self.lastJawClench = packet.jawClench
        
        
        // }
        
        
        
    }
    
    
    
    func receive(_ packet: IXNMuseConnectionPacket, muse: IXNMuse?) {
        
        var currentState = ""
        switch packet.currentConnectionState{
            
        case .unknown:
            currentState = "Unknown"
        case .connected:
            currentState = "Connected"
            delegate?.museConnected()
        case .connecting:
            currentState = "Connecting"
            
        case .disconnected:
            currentState = "Disconnected"
//            if isDeviceConnectedBefore {
//                isDeviceConnectedBefore = false
//                connectMuse()
//            }
        case .needsUpdate:
            currentState = "Needs update"
            
        case .needsLicense:
            currentState = "Needs license"
            
        @unknown default:
            currentState = "Impossible connection state"
        }
        
        logMuse(str: "connect: \(currentState)")
        
    }
    
    
    func museListChanged() {
        //contentView.tableView.reloadData()
        delegate?.museListUpdated()
    }
    
    
    func receiveLog(_ log: IXNLogPacket) {
        let str = String(format: "%@: %f raw:%d %@", log.tag, log.timestamp, log.raw, log.message)
        logMuse(str: str)
    }
    
    
}
