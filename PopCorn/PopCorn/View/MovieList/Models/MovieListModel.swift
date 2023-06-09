import Foundation

struct MovieItem: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}

class MovieAPI {
    static let apiKey = "8e45d525eb45dc5a33b50231cefad2f9"
    
    static func fetchMovies(category: String, page: Int, completion: @escaping ([MovieItem]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(category)?api_key=\(apiKey)&language=fr-FR&page=\(page)") else {
                completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return
            }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Utiliser la stratégie de décodage pour les dates au format ISO8601
            do {
                var movies: [MovieItem] = [] // Créer un tableau vide pour stocker les données décodées
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let jsonArray = jsonObject["results"] as? [[String: Any]] {
                        for json in jsonArray {
                            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []),
                               let movie = try? decoder.decode(MovieItem.self, from: jsonData) {
                                movies.append(movie) // Ajoute le film décodé au tableau
                            }
                        }
                    }
                }
                completion(movies, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }.resume()
    }
}
