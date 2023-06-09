//
//  LocationManager.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import SwiftUI
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @Published var cinemas: [CinemaAnnotation] = []

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location.coordinate

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }

                guard let placemark = placemarks?.first else {
                    print("No placemark found")
                    return
                }

                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = "cinema"
                request.region = MKCoordinateRegion(center: placemark.location!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

                let search = MKLocalSearch(request: request)
                search.start { response, error in
                    if let error = error {
                        print("Local search error: \(error.localizedDescription)")
                        return
                    }

                    guard let mapItems = response?.mapItems else {
                        print("No map items found")
                        return
                    }

                    let cinemas = mapItems.map { mapItem -> CinemaAnnotation in
                        return CinemaAnnotation(
                            coordinate: mapItem.placemark.coordinate,
                            title: mapItem.name ?? "",
                            subtitle: mapItem.placemark.title ?? ""
                        )
                    }

                    DispatchQueue.main.async {
                        self.cinemas = cinemas
                    }
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}
