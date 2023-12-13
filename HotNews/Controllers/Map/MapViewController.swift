//
//  MapsViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 13.12.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var indexPoint: Int = 0
    var points: [MapPoint] = [] {
        
        didSet {
            if points.count == 5 {
                do {
                    let encoder = PropertyListEncoder()
                    let data = try encoder.encode(points)
                    UserDefaults.standard.set(data, forKey: "mapPoints")
                } catch {
                    print("Ошибка при сохранении в UserDefaults: \(error)")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchedMap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        loadAnnotations()
    }
    
    private func loadAnnotations() {
        
        if let data = UserDefaults.standard.data(forKey: "mapPoints") {
            
            do {
                
                let decoder = PropertyListDecoder()
                let decodedPoints = try decoder.decode([MapPoint].self, from: data)
                self.points = decodedPoints
                
                for point in points {
                    let annotation = MKPointAnnotation()
                    annotation.title = point.title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                    mapView.addAnnotation(annotation)
                }
                
                let location = CLLocation(latitude: self.points[4].latitude,
                                          longitude: self.points[4].longitude)
                let radiusRegion: CLLocationDistance = 1000
                let coordinateRegion = MKCoordinateRegion(
                    center: location.coordinate,
                    latitudinalMeters: radiusRegion,
                    longitudinalMeters: radiusRegion
                )
                mapView.setRegion(coordinateRegion, animated: true)
                
            } catch {
                print("Ошибка при загрузке из UserDefaults: \(error)")
            }
        }
    }
    
    @objc func touchedMap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if points.count < 5 {
                
                indexPoint += 1
                let locationInView = gesture.location(in: mapView)
                let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
                let point = MapPoint(title: "Point \(indexPoint)", latitude: coordinate.latitude, longitude: coordinate.longitude)
                points.append(point)

                let annotation = MKPointAnnotation()
                annotation.title = point.title
                annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                mapView.addAnnotation(annotation)
                
            } else {
                
                indexPoint = 0
                points.removeAll()
                mapView.removeAnnotations(mapView.annotations)
                UserDefaults.standard.removeObject(forKey: "mapPoints")
            }
        }
    }
}
