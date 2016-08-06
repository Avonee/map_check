//
//  ViewController.swift
//  map_checkpoint
//
//  Created by rubl333 on 2016/6/9.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase

//public func GetDistance_Google(pointA:CLLocationCoordinate2D , pointB:CLLocationCoordinate2D) -> Double
//{
//    let EARTH_RADIUS:Double = 6378.137;
//    
//    let radlng1:Double = pointA.longitude * M_PI / 180.0;
//    let radlng2:Double = pointB.longitude * M_PI / 180.0;
//    
//    let a:Double = radlng1 - radlng2;
//    let b:Double = (pointA.latitude - pointB.latitude) * M_PI / 180;
//    var s:Double = 2 * asin(sqrt(pow(sin(a/2), 2) + cos(radlng1) * cos(radlng2) * pow(sin(b/2), 2)));
//    
//    s = s * EARTH_RADIUS;
//    s = (round(s * 10000) / 10000);
//    print("距離是\(s)km")
//    return s;
//}


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var uimap: MKMapView!//地圖元件
    var location : CLLocationManager! //座標管理元件
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location = CLLocationManager()
        location.delegate = self
        
        //詢問使用者是否同意給APP定位功能
        location.requestWhenInUseAuthorization()
        //開始接收目前位置資訊
        location.startUpdatingLocation()
        location.distanceFilter = CLLocationDistance(10); //表示移動10公尺再更新座標資訊
        
        
        //取得firebase 現有的座標資料
    _ = FIRDatabase.database().reference().observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            let postDict = snapshot.value as! [String : AnyObject]
            print("取到啥？\(postDict)")
        })

        
    }
    
    override func viewDidDisappear(animated: Bool) {
        //因為ＧＰＳ功能很耗電,所以被敬執行時關閉定位功能
        location.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //取得目前的座標位置
        let c = locations[0] 
        //c.coordinate.latitude 目前緯度
        //c.coordinate.longitude 目前經度
        let nowLocation = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude)
        
        //將map中心點定在目前所在的位置
        //span是地圖zoom in, zoom out的級距
        let _span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
        self.uimap.setRegion(MKCoordinateRegion(center: nowLocation, span: _span), animated: true)
        
        //加入座標
        addPointAnnotation(c.coordinate.latitude, longitude: c.coordinate.longitude)
        
        let name: String? = userDefault.objectForKey("nickName") as! String?
        
//        FIRDatabase.database().reference().child("users").setValue(["uid": name!, "location": ["lat":c.coordinate.latitude,"lng":c.coordinate.longitude]])
        
        
        FIRDatabase.database().reference().child("users/\(name!)").setValue(["location": ["lat":c.coordinate.latitude,"lng":c.coordinate.longitude]])
        
        ///有給亂碼的方法
//        let key = FIRDatabase.database().reference().child("users").childByAutoId().key
//        let post = ["uid": name!,
//                    "location": [c.coordinate.latitude,c.coordinate.longitude]]
//        let childUpdates = ["\(key)": post,
//                            "/user-update/\(name!)/\(key)/": post]
//        
//        FIRDatabase.database().reference().updateChildValues(childUpdates)

    }
    
    //新增座標
    private func addPointAnnotation(latitude:CLLocationDegrees , longitude:CLLocationDegrees){
        //大頭針
        let point:MKPointAnnotation = MKPointAnnotation()
        //設定大頭針的座標位置
        point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        point.title = "Avon's here"
        point.subtitle = "緯度：\(latitude) 經度:\(longitude)"
        
        uimap.addAnnotation(point)
    }
    
   
    

    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        //取得目前的座標位置
//        let c = locations[0] as! CLLocation;
//        //c.coordinate.latitude 目前緯度
//        //c.coordinate.longitude 目前經度
//        let nowLocation = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude);
//        
//        //將map中心點定在目前所在的位置
//        //span是地圖zoom in, zoom out的級距
//        let _span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005);
//        self.uimap.setRegion(MKCoordinateRegion(center: nowLocation, span: _span), animated: true);
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

