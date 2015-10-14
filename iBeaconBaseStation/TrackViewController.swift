//
//  TrackViewController.swift
//  iBeaconBaseStation
//
//  Created by 徐继垚 on 15/10/14.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit

import CoreBluetooth
import CoreLocation

class TrackViewController: UIViewController ,CLLocationManagerDelegate {

    @IBOutlet weak var beaconLable: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    
    var beconRegion : CLBeaconRegion!
    
    var beaconArr : NSArray!
    
    var trackLocationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       self.title = "Track"
        
        
        self.trackLocationManager = CLLocationManager()
        self.trackLocationManager.delegate = self

        initRegion()
               // Do any additional setup after loading the view.
    }
    

 
    func initRegion() {
        let uuid = NSUUID(UUIDString: "DD7D9825-5E2F-4ED6-BB98-2768505ACA20")
        
        self.beconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "xujiyao")
        
        self.trackLocationManager.requestAlwaysAuthorization()
        
        self.trackLocationManager.startRangingBeaconsInRegion(self.beconRegion)
        self.trackLocationManager.startMonitoringForRegion(self.beconRegion)
        
      //  self.trackLocationManager.startRangingBeaconsInRegion(self.beconRegion)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedAlways{
            
            self.trackLocationManager.startRangingBeaconsInRegion(self.beconRegion)
         
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        self.trackLocationManager.startRangingBeaconsInRegion(self.beconRegion)
//           self.trackLocationManager.startMonitoringForRegion(self.beconRegion)
        
        print(region)
    }
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.trackLocationManager.stopRangingBeaconsInRegion(self.beconRegion)
        self.beaconLable.text = "NO"
        
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        print(beacons)
        
        
        if beacons.count <= 0 {
            return
        }
        
        let beacon : CLBeacon = beacons[beacons.count - 1]
        
        self.beaconLable.text = "YES"
        self.uuidLabel.text = beacon.proximityUUID != "" ? beacon.proximityUUID.UUIDString : ""
        
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
