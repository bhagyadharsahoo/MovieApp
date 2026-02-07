//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//
import Foundation
import Combine


@MainActor
class MovieDetailViewModel: ObservableObject {
        @Published var title = ""
        @Published var overview = ""
        @Published var runtime: Int?
        @Published var voteAverage: Double = 0
        @Published var genres: [Genre] = []
        @Published var movieId = 0
        @Published var cast: [CastMember] = []
       @Published var videos: [VidioDataModel.Result] = []
    
    
    
    private let service: DetailPageActionable
    
    init(movieId: Int) {
        self.movieId = movieId
        self.service = MoviesDataServies()
    }
    
    func loadDetails() async {
        async let details = service.getMovieDetails(movieId: movieId)
        async let videoResponse = service.getMovieVideos(movieId: movieId)
        
        do {
            let detailData = try await details
            let videosData = try await videoResponse
           
            
            await MainActor.run {
                // Details
                title = detailData.title ?? ""
                overview = detailData.overview ?? ""
                runtime = detailData.runtime
                voteAverage = detailData.voteAverage ?? 0
                genres = detailData.genres ?? []
                
                cast = detailData.credits.cast.map { $0 }
             
                videos = videosData.results ?? []
                
            }
        } catch {
            print("Detail load error: \(error)")
        }
    }
    
    var trailer: VidioDataModel.Result? {
        videos.first {
            $0.type == "Trailer" &&
            $0.official == true &&
            $0.key?.isEmpty == false  // ✅ Valid key!
        }
    }

      
      var clips: [VidioDataModel.Result] {
          videos.filter { $0.type == "Clip" && ($0.official ?? false)}
      }
}
