//
//  MovieListView.swift
//  PopCorn
//
//  Created by digital on 18/04/2023.
//

import SwiftUI
import Foundation

struct MovieListView: View {
    @ObservedObject private var movieData = MovieData()
    @State private var isLoadingNextPage = false
    @State private var isShowingMap = false
    
    var pickerView: some View{
        Picker(selection: $movieData.selectedCategory, label: Text("Catégorie")) {
            Text("Tendance").tag(0)
            Text("Mieux noté").tag(1)
            Text("Nouveautés").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                pickerView
                
                Spacer()
                
                if movieData.movies.isEmpty {
                    ProgressView()
                } else {
                    List(movieData.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, viewModel: MovieDetailsViewModel())) {
                            MovieListItemView(movie: movie).onAppear {
                                // Vérifier si c'est le dernier élément de la liste
                                if movie.id == movieData.movies.last?.id {
                                    // Charger la page suivante
                                    movieData.loadNextPage()
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Films")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingMap = true
                    }) {
                        Image(systemName: "map")
                            .imageScale(.large)
                    }
                    
                    .sheet(isPresented: $isShowingMap) {
                        CineMap()
                    }
                    
                }
            }
        }
        .onAppear {
            movieData.fetchMoviesForCategory()
        }
        .onChange(of: movieData.selectedCategory) { _ in
            movieData.fetchMoviesForCategory()
        }
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
