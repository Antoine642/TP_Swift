//
//  MovieDetailView.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import SwiftUI

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let decodeDateFormat: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }()
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(spacing: 16) {
                    if let posterImageName = viewModel.movieDetails?.posterPath {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterImageName)")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 0)
                                .foregroundColor(.gray)
                                .frame(height: 300)
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 0))
                        .shadow(radius: 10)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.movieDetails?.title ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if let subtitle = viewModel.movieDetails?.tagline {
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            if let release = viewModel.movieDetails?.releaseDate,
                               let date = decodeDateFormat.date(from: release) {
                                Text(stackDateFormat.string(from: date))
                            } else {
                                Text("Pas de date")
                            }
                            
                            Text("•")
                            
                            if let runtime = viewModel.movieDetails?.runtime {
                                let hours = runtime / 60
                                let minutes = runtime % 60
                                Text("\(hours)h \(minutes)min")
                            } else {
                                Text("Durée inconnue")
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Synopsis")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text(viewModel.movieDetails?.overview ?? "")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        if let posterBackdropName = viewModel.movieDetails?.backdropPath {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterBackdropName)")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 0)
                                    .foregroundColor(.gray)
                                    .frame(height: 250)
                            }
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                            .shadow(radius: 10)
                        }
                        if let trailerKey = viewModel.videoKey {
                            HStack(){
                                Button(action: {
                                    let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)")
                                    if let url = youtubeURL {
                                        if UIApplication.shared.canOpenURL(URL(string: "youtube://")!) {
                                            // Ouvrir l'URL dans l'application YouTube si elle est disponible
                                            UIApplication.shared.open(url)
                                        } else {
                                            // Ouvrir l'URL dans Safari si l'application YouTube n'est pas trouvée
                                            openURL(url)
                                        }
                                    }
                                }) {
                                    Text("Regarder la bande annonce")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(maxWidth: .infinity)
                                .alignmentGuide(.leading) { _ in UIScreen.main.bounds.size.width / 2 }
                                
                                Spacer()
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Genres")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text(viewModel.movieDetails?.genres.map { $0.name }.joined(separator: ", ") ?? "")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Compagnies de production")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text(viewModel.movieDetails?.productionCompanies.map { $0.name }.joined(separator: ", ") ?? "")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Utiliser la fonction dismiss() pour fermer la vue modale
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(12) // Réduire la taille du bouton
                    .background(Color.gray)
                    .clipShape(Circle())
                    .offset(x: 15, y: 0)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchMovieDetails(movieId: movieId)
        }
    }
}

