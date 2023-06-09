import Foundation

class MovieData: ObservableObject {
    @Published var movies: [MovieItem] = []
    @Published var selectedCategory = 0
    @Published var currentPage = 1
    @Published var isLoadingNextPage: Bool = false
    
    func fetchMoviesForCategory() {
        // Réinitialiser la liste des films et la page courante
        movies = []
        currentPage = 1
        
        switch selectedCategory {
        case 0: // Tendance
            MovieAPI.fetchMovies(category: "popular", page: currentPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies = movies
                    }
                }
            }
        case 1: // Mieux noté
            MovieAPI.fetchMovies(category: "top_rated", page: currentPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies = movies
                    }
                }
            }
        case 2: // Autre catégorie
            MovieAPI.fetchMovies(category: "upcoming", page: currentPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies = movies
                    }
                }
            }
        default:
            break
        }
    }
    
    func loadNextPage() {
        guard !isLoadingNextPage else {
            return
        }
        
        isLoadingNextPage = true
        let nextPage = currentPage + 1
        
        switch selectedCategory {
        case 0: // Tendance
            MovieAPI.fetchMovies(category: "popular", page: nextPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies += movies
                        self?.currentPage = nextPage
                        self?.isLoadingNextPage = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.isLoadingNextPage = false
                    }
                }
            }
        case 1: // Mieux noté
            MovieAPI.fetchMovies(category: "top_rated", page: nextPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies += movies
                        self?.currentPage = nextPage
                        self?.isLoadingNextPage = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.isLoadingNextPage = false
                    }
                }
            }
        case 2: // Autre catégorie
            MovieAPI.fetchMovies(category: "upcoming", page: nextPage) { [weak self] movies, error in
                if let movies = movies {
                    DispatchQueue.main.async {
                        self?.movies += movies
                        self?.currentPage = nextPage
                        self?.isLoadingNextPage = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.isLoadingNextPage = false
                    }
                }
            }
        default:
            isLoadingNextPage = false
            break
        }
    }
}
