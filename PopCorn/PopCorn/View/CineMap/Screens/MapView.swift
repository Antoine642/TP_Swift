//
//  MapView.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var regionRadius: CLLocationDistance
    var cinemas: [CinemaAnnotation]
    @Binding var isCenterOnUser: Bool // Ajout de la variable d'état pour le système "on/off"

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false // Désactiver la rotation de la carte
        mapView.showsUserLocation = true // Afficher le point de localisation de l'utilisateur
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if isCenterOnUser {
            if centerCoordinate.latitude != view.centerCoordinate.latitude ||
                centerCoordinate.longitude != view.centerCoordinate.longitude {
                view.setCenter(centerCoordinate, animated: true)

                let coordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                view.setRegion(coordinateRegion, animated: true)
            }
        }

        // Supprimer les anciennes annotations
        view.removeAnnotations(view.annotations)

        // Ajouter les annotations des cinémas
        let cinemaAnnotations: [MKAnnotation] = cinemas.map { cinema -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = cinema.coordinate
            annotation.title = cinema.title
            annotation.subtitle = cinema.subtitle
            return annotation
        }
        view.addAnnotations(cinemaAnnotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // MARK: - MKMapViewDelegate

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else {
                return nil
            }

            let identifier = "CinemaAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
    }
}
