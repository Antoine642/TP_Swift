//
//  CinemaAnnotation.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import MapKit

struct CinemaAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}
