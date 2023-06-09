//
//  ContentView.swift
//  PopCorn
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
               Text("Bienvenue sur l'écran 1")
                   .font(.largeTitle)
               
               NavigationLink("Aller à l'écran 2", destination: MovieDetailView(movieId: 550, viewModel: MovieDetailsViewModel())) // Utiliser la vue 2
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(8)
                   .padding()
            }
            .navigationBarTitle("Écran 1")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}

/*
 hstack horizontal
 vstack vertical
 zstack element les un sur les autres
 composant -> taille -> taille(.frame(maxWidth: .infinity, alignement: .leading) sera d'une
    taille x puis prendra tout l'espace possible et l'element interne sera aligné a gauche
 
 + de composants sans la barre en haut => "+"
 
 scrollview = scroll
 
 lazyvstack => lazy load les elements non affichés
 */
