//
//  MoviesView.swift
//  PopCorn
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

struct MoviesView: View {
    @State private var moviesData: [[String: AnyHashable]] = [
        [
            "movieTitle": "Titanic",
            "movieSubtitle": "Un film romantique et dramatique",
            "release_date": "1997-12-19",
            "duration": 194,
            "categories": ["Romance", "Drame"],
            "synopsis": "Jack, un artiste fauché, monte à bord du Titanic, un paquebot de luxe, et tombe amoureux de Rose, une jeune femme de la haute société.",
            "poster": "titanic_poster",
            "affiche": "titanic_cover"
        ],
        [
            "movieTitle": "The Shawshank Redemption",
            "movieSubtitle": "Un film dramatique",
            "release_date": "1994-09-23",
            "duration": 142,
            "categories": ["Drame", "Crime"],
            "synopsis": "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
            "poster": "shawshank_redemption_poster",
            "affiche": "shawshank_redemption_cover"
        ],
        [
            "movieTitle": "The Godfather",
            "movieSubtitle": "Un film de gangsters",
            "release_date": "1972-03-24",
            "duration": 175,
            "categories": ["Crime", "Drame"],
            "synopsis": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
            "poster": "godfather_poster",
            "affiche": "godfather_cover"
        ]
    ]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(){
            LazyVGrid(columns: columns){
                ForEach(moviesData, id: \.self) { movie in
                    VStack(){
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.red)
                            .frame(width: .infinity, height: 150)
                            
                        Text(movie["movieTitle"] as? String ?? "")
                            .fontWeight(.bold)
                        Text(movie["release_date"] as? String ?? "")
                        Text("\(movie["duration"] as? Int ?? 0) minutes")
                    }
                    .frame(maxHeight: 250)
                    .frame(alignment: .top)
                }
            }
            .padding()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
