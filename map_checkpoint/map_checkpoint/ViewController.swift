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



class ViewController: UIViewController, CLLocationManagerDelegate {
    
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

