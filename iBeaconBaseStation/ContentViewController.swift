//
//  ContentViewController.swift
//  iBeaconBaseStation
//
//  Created by 徐继垚 on 15/10/15.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ContentViewController: UIViewController {

    @IBOutlet weak var beaconLable: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var uuidField: UITextField!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var beacon : CLBeacon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
                self.beaconLable.text = "YES"
                self.uuidField.text = beacon.proximityUUID != "" ? beacon.proximityUUID.UUIDString : ""
        
                self.majorLabel.text = beacon.major.stringValue != "" ? beacon.major.stringValue : ""
                self.minorLabel.text = beacon.minor.stringValue != "" ? beacon.minor.stringValue : ""
        
                self.accuracyLabel.text = String(beacon.accuracy) != "" ? String(beacon.accuracy) : ""
        
        
        
                switch(beacon.proximity) {
                case .Unknown:
                    self.distanceLabel.text = "unknown"
                case .Immediate:
                    self.distanceLabel.text = "immediate"
                case .Near:
                    self.distanceLabel.text = "near"
                case .Far:
                    self.distanceLabel.text = "far"
                }
                
                self.rssiLabel.text = beacon.rssi.description != "" ? beacon.rssi.description : ""
        
        
        
        // Do any additional setup after loading the view.
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
