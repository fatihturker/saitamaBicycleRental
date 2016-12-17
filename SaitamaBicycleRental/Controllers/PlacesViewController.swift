//
//  PlacesViewController.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import UIKit
import GoogleMaps

class PlacesViewController: UIViewController, GMSMapViewDelegate {
    let registerObserverName: String = "onRegisterOperationDone"
    
    var getPlacesObserverName: String = "onGetPlacesOperationDone"
    var places: [Models.Renter]! = nil{
        didSet{
            if places != nil{
                DispatchQueue.main.async {
                    self.createMarkers(places: self.places)
                }
            }
        }
    }
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet var mapView_: GMSMapView?
    var placesProvider: Controllers.Providers.PlacesProvider!
    var tokenProvider: Controllers.Providers.TokenProvider!
    
    var selectedRenter: Models.Renter!
    override func viewDidLoad() {
        super.viewDidLoad()
        let bounds = UIScreen.main.bounds
        let widthScale = bounds.width / CGFloat(375.0)
        
        let heightScale = bounds.height / CGFloat(667.0)
        let camera = GMSCameraPosition.camera(withLatitude: 36.20, longitude: 138.25, zoom: 9.0)
        mapView_ = GMSMapView.map(withFrame: CGRect(x: mapView.frame.origin.x, y: mapView.frame.origin.y, width: mapView.frame.width * widthScale, height: mapView.frame.height * heightScale), camera: camera)
        mapView_?.isMyLocationEnabled = true
        mapView_?.delegate = self
        self.view.addSubview(mapView_!)
        placesProvider = Controllers.Providers.PlacesProvider()
        tokenProvider = Controllers.Providers.TokenProvider()
        // Adding observer for get places operation
        NotificationCenter.default.addObserver(self, selector: #selector(onGetPlacesOperationDone), name: Notification.Name(getPlacesObserverName), object: nil)
        placesProvider.getPlaces(observer: getPlacesObserverName)
        // Do any additional setup after loading the view.
    }
    
    /** On get places operation done this method will be notified */
    func onGetPlacesOperationDone(notification: Notification){
        let userInfo = notification.userInfo
        if let data = userInfo?["data"]{
            let dataObject = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
            places = try? placesProvider.getPlaces(dao: dataObject!)
        }else if let error = userInfo?["error"]{
            print(String(data: error as! Data, encoding: String.Encoding.utf8)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** Creates markers on map view */
    func createMarkers(places: [Models.Renter]){
        //todo: Custom Marker will be designed with a renter name and rent button
        var lastLocation: CLLocationCoordinate2D? = nil
        for place in places{
            let marker = GMSMarker()
            marker.position = place.location
            marker.title = place.name
            marker.userData = place
            marker.map = mapView_
            lastLocation = place.location
        }
        //focusing last marker location
        mapView_?.camera = GMSCameraPosition.camera(withLatitude: (lastLocation?.latitude)!, longitude: (lastLocation?.longitude)!, zoom: 9.0)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        selectedRenter = marker.userData as! Models.Renter!
        self.performSegue(withIdentifier: "segPlacesToRentBicycle", sender: self)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segPlacesToRentBicycle"{
            let dest = segue.destination as? RentBicycleViewController
            //passing selected renter to rentBicycle page
            dest?.renter = self.selectedRenter
        }
    }
    
    /** Performs sign out operations */
    @IBAction func signOut(_ sender: Any) {
        tokenProvider.clearToken()
        self.performSegue(withIdentifier: "segPlacesToMain", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
