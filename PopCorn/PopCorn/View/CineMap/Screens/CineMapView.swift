//
//  CineMapView.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import SwiftUI
import MapKit

struct CineMap: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager()
    @State private var isCenterOnUser = true // Ajout de la variable d'état pour le système "on/off"

    var body: some View {
        NavigationView {
            VStack {
                MapView(centerCoordinate: $locationManager.currentLocation, regionRadius: 1000, cinemas: locationManager.cinemas, isCenterOnUser: $isCenterOnUser) // Passage de la variable d'état à la vue MapView
                    .edgesIgnoringSafeArea(.all)
                    .gesture(DragGesture().onChanged { _ in
                        isCenterOnUser = false // Désactiver le centrage sur l'utilisateur lorsqu'il fait un drag sur la carte
                    })
                    .overlay(
                        GeometryReader { geo in
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        isCenterOnUser = true // Activer le centrage sur l'utilisateur lorsque le bouton est appuyé
                                        locationManager.requestLocation()
                                    }) {
                                        Image(systemName: "location.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.blue)
                                    }
                                    .padding(16)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .offset(x: -16, y: -16)
                                }
                            }
                        }
                    )
            }
            .navigationBarItems(leading: backButton)
        }
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .foregroundColor(.blue)
        }
    }
}

struct CineMap_Previews: PreviewProvider {
    static var previews: some View {
        CineMap()
    }
}

