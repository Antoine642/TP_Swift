//
//  MovieDetailsViewModel.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var videoKey: String?
    
    func fetchMovieDetails(movieId: Int) {
        let apiKey = "8e45d525eb45dc5a33b50231cefad2f9"
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=fr-FR&append_to_response=videos") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                DispatchQueue.main.async {
                    self.movieDetails = movieDetails
                    if let videos = movieDetails.videos?.results.first {
                        self.videoKey = videos.key
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}


