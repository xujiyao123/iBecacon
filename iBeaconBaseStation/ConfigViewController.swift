//
//  ConfigViewController.swift
//  iBeaconBaseStation
//
//  Created by 徐继垚 on 15/10/14.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ConfigViewController: UIViewController , CBPeripheralManagerDelegate {

    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    
    

    
    var beaconRegion : CLBeaconRegion!
    var beaconPeripheraData : NSDictionary!
    var peripheralManager : CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Config"

        
        
        initBeacon()
        
        
        // Do any additional setup after loading the view.
    }
    func initBeacon() {
        
        
       let uuid = NSUUID(UUIDString: "DD7D9825-5E2F-4ED6-BB98-2768505ACA20")
        
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 1, minor: 1, identifier: "xujiyao")
        
        
    }

    @IBAction func TransmateAction(sender: UIButton) {
        
        
        self.beaconPeripheraData = self.beaconRegion.peripheralDataWithMeasuredPower(nil)
        
        
    
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        
        if peripheral.state == CBPeripheralManagerState.PoweredOn {
            print("Power On")
            self.peripheralManager.startAdvertising(self.beaconPeripheraData as? [String : AnyObject])
            
            
            
     
            
            setLabels()
            
        }
        else if peripheral.state == .PoweredOff{
            print("Power OFF")
            self.peripheralManager.stopAdvertising()
        }
        
        
        
    }
    func setLabels() {
        self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString
        self.majorLabel.text = self.beaconRegion.major?.stringValue
        self.minorLabel.text = self.beaconRegion.minor?.stringValue
        self.identifierLabel.text = self.beaconRegion.identifier
        print(self.beaconRegion.proximityUUID.UUIDString ,self.beaconRegion.major?.stringValue,self.beaconRegion.minor?.stringValue,self.beaconRegion.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
