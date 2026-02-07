//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import SwiftUI
import WebKit

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel: MovieDetailViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    init(movieId: Int) {
        self.movieId = movieId
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                // 1. VIDEO PLAYER (TOP - Full Width)
              videosSection
                
                // 2. Title & Rating
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.title2)
                        Text("\(viewModel.voteAverage)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                
                // 3. Duration & Genres
                HStack(spacing: 12) {
                    if let runtime = viewModel.runtime {
                        Label("\(runtime) min", systemImage: "clock")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(20)
                    }
                    
                    HStack(spacing: 8) {
                        ForEach(viewModel.genres.prefix(3), id: \.id) { genre in
                            Text(genre.name ?? "")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                }
                
                // 4. Plot
                VStack(alignment: .leading, spacing: 12) {
                    Text("Overview")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(viewModel.overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                if !viewModel.cast.isEmpty {
                                 VStack(alignment: .leading, spacing: 12) {
                                     Text("Cast")
                                         .font(.title3)
                                         .fontWeight(.semibold)
                                     
                                     ScrollView(.horizontal, showsIndicators: false) {
                                         HStack(spacing: 16) {
                                             ForEach(viewModel.cast) { member in
                                                 VStack(spacing: 8) {
                                                     
                                                     Text(member.name)
                                                         .font(.caption)
                                                         .fontWeight(.medium)
                                                         .multilineTextAlignment(.center)
                                                         .lineLimit(2)
                                                 }
                                             }
                                         }
                                     }
                                 }
                             }
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritesManager.toggleFavorite(movieId)
                } label: {
                    Image(systemName: favoritesManager.isFavorite(movieId) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.title2)
                }
            }
        }
        .onAppear {
            Task {
                viewModel.movieId = movieId
                await viewModel.loadDetails()
            }
        }
    }
    
    @State private var selectedVidio: VidioDataModel.Result?

    private var videosSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "film")
                Spacer()
            }
            
            // MAIN PLAYER
            Group {
                if let selectedVidio = selectedVidio ?? viewModel.trailer {
                    mainVidioPlayer(for: selectedVidio)
                } else {
//                    videoPlaceholder
                }
            }
            
            // THUMBNAILS
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.videos) { vidio in
                        vidioThumbnail(vidio)
                            .onTapGesture {
                                selectedVidio = vidio  // ✅ Works with your model!
                            }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func mainVidioPlayer(for vidio: VidioDataModel.Result) -> some View {
        VStack(spacing: 12) {
            YouTubePlayer(videoID: vidio.key ?? "", height: 240)  // ✅ vidio.key
                .frame(height: 240)
                .clipped()
                .cornerRadius(16)
            
            HStack {
                Text(vidio.type ?? "")  // ✅ vidio.type ("Trailer"/"Clip")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(12)
                
                Text(vidio.name ?? "")  // ✅ vidio.name
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func vidioThumbnail(_ vidio: VidioDataModel.Result) -> some View {
        VStack(spacing: 6) {
            AsyncImage(url: vidio.thumbnailURL) { image in
                image.resizable().scaledToFill()
                    .overlay(alignment: .center) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.3)
                    Image(systemName: "play.circle")
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .frame(width: 140, height: 80)
            .clipped()
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        selectedVidio?.id == vidio.id ? Color.blue : Color.clear,
                        lineWidth: 3
                    )
            )
            
            Text(vidio.name ?? "")  // ✅ vidio.name
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }


}



