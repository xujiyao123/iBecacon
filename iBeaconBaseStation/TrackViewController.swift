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

class TrackViewController: UIViewController ,CLLocationManagerDelegate ,UITableViewDataSource ,UITableViewDelegate {

 
    
    
    var beconRegion : CLBeaconRegion!
    
    var beaconArr = [CLBeacon]()
    
    var trackLocationManager : CLLocationManager!
    
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       self.title = "Track"
        
        
        tableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        

               // Do any additional setup after loading the view.
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        switch motion {
        case .MotionShake :
//            let alert = UIAlertController(title: "恭喜你，成功了！", message: nil, preferredStyle: .Alert)
//            
//            alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
//            
//            self.presentViewController(alert, animated: true, completion: nil)
            
            self.trackLocationManager = CLLocationManager()
            self.trackLocationManager.delegate = self
            
            initRegion()
            
        default:
            break
        }
    }

    

 
    func initRegion() {
        let uuid = NSUUID(UUIDString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")
        
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
//        self.beaconLable.text = "NO"
        
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        print(beacons)
        
        
        if beacons.count <= 0 {
            return
        }
        
        self.beaconArr = beacons 
        
        self.tableView.reloadData()
        
     //   self.trackLocationManager.stopRangingBeaconsInRegion(self.beconRegion)
        

        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if beaconArr.count == 0 {
            return 0
        }
        return beaconArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = beaconArr[indexPath.row].proximityUUID.UUIDString
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ContentViewController()
        
        vc.beacon = beaconArr[indexPath.row] 
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
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
