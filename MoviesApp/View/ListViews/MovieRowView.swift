//
//  MovieRowView.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import SwiftUI


struct MovieRowView: View {
    let movie: PopularDataModel.Result
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 120)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Color.gray
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                if let titel = movie.title {
                    Text(titel)
                        .font(.headline)
                        .lineLimit(2)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                        Text(movie.durationText)   // Duration
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                }

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(movie.ratingText)     // Rating
                        .font(.subheadline)
                }
                
                Button {
                    favoritesManager.toggleFavorite(movie.id ?? 0)
                    } label: {
                        Image(systemName: favoritesManager.isFavorite(movie.id ?? 0) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(.red)
                            .scaleEffect(favoritesManager.isFavorite(movie.id ?? 0) ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: favoritesManager.isFavorite(movie.id ?? 0))
                    }
                    .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(.vertical, 8)
    }
}
