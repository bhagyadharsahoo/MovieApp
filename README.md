	•	✅ Movie List - Popular movies with infinite scroll pagination
	•	✅ Search - Live search with pagination (preserves state on navigation)
	•	✅ Movie Details - Full details + YouTube trailer player
	•	✅ Favorites - Heart button (list + detail), persists across app restarts
	•	✅ Modern Networking - Async/await, protocol-based, testable endpoints
	•	✅ Clean Architecture - Models/Networking/Views/ViewModels separation
 git clone https://github.com/bhagyadharsahoo/MovieApp.git
cd MovieApp
open MoviesApp.xcodeproj

🎯 Implemented Features
✅ Movie List
	•	Popular movies ( /movie/popular ) with pagination
	•	Infinite scroll (loads next page at bottom)
✅ Search
	•	Live search ( /search/movie ) with 500ms debounce
	•	Preserves results on navigation to/from detail
	•	Pagination works for search results
	•	Dynamic title: “Movies” ↔ “Search Results”
✅ Movie Detail
	•	Full details ( /movie/{id}  +  credits )
	•	YouTube trailer player ( /movie/{id}/videos )
	•	Cast carousel with profile images
	•	Plot ( overview ), genres, runtime, rating
✅ Favorites
	•	❤️ Heart button (list rows + detail toolbar)
	•	Smooth animations (scale + bounce)
	•	Persistent (UserDefaults) - survives app restarts
	•	Live sync across screens
