import SwiftUI

struct MovieListItemView: View {
    let movie: MovieItem
    
    var body: some View {
        HStack(spacing: 16) {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "film")
                            .frame(width: 50, height: 70)
                    case .empty:
                        Image(systemName: "film")
                            .frame(width: 50, height: 70)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 50, height: 70)
            } else {
                Image(systemName: "film")
                    .frame(width: 50, height: 70)
            }
            Text(movie.title)
        }
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItemView(movie: MovieItem(id: 12345,
                                           title: "Le film",
                                           overview: "test",
                                           releaseDate: "2023-06-01",
                                           posterPath: "poster.jpg",
                                           backdropPath: "backdrop.jpg",
                                           voteAverage: 7.8))
    }
}
