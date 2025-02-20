//
//  SwiftUIViewDetails.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 17/2/25.
//

import SwiftUI


struct SwiftUIViewDetails: View {
    
    var id:Int?
    @State var movie: Movie?
    @State var reviews: Reviews?
    @State var similar: SimilarMovie?
    
    var https = Https()
    @State var starRating = StarRating()
    
    var body: some View {
        ScrollView {
            VStack {
                Section {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie?.poster_path ?? "")")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.red
                    }
                    .frame(width: 400, height: 300)
                    .clipShape(.rect(cornerRadius: 25))
                }
                
                Section {
                    Text("\(movie?.title ?? "")").font(.largeTitle)
                    LazyHStack {
                        ForEach(movie?.genres ?? [],id: \.id) { genre in
                            Text("\(genre.name)")
                        }
                    }
                    Text("Runtime").font(.title3)
                    Text("\(movie?.runtime ?? 0) min")
                    Text("Date").font(.title3)
                    Text("\(movie?.release_date ?? "")")
                    Text("Rating").font(.title3)
                    StarsView(rating: (movie?.vote_average as? CGFloat ?? 2.6), maxRating: 10)
                    Text("Description").font(.title3)
                    Text("\(movie?.overview ?? "")")
                }.frame(width: 400,alignment: Alignment.leading)
                
                Section {
                    Text("Casting")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(movie?.credits?.cast ?? [], id: \.profile_path) { cast in
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(cast.profile_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.red
                                    }
                                    .frame(width: 80, height: 80)
                                    
                                    Text("\(cast.name ?? "Angelina")")
                                }
                            }
                        }
                    }
                }.frame(width: 400,alignment: Alignment.leading)
                
                Section {
                    Text("Similar Movies")
                    ScrollView(.horizontal) {
                        LazyHStack{
                            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(similar?.results[0].backdrop_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 80, height: 80)
                                
                            }
                            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(similar?.results[1].backdrop_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 80, height: 80)
                                
                            }
                        }
                    }
                }
                
                Section {
                    Text("Movie Reviews")
                    ScrollView(.vertical) {
                        LazyVStack{
                            if ((reviews?.results.count) ?? 0 > 0) {
                                VStack {
                                    Text("\(reviews?.results[0].author_details?.username ?? " ")").font(.largeTitle)
                                    
                                    Text(AttributedString(reviews?.results[0].content ?? ""))
                                }
                                VStack {
                                    Text("\(reviews?.results[1].author_details?.username ?? " ")").font(.largeTitle)


                                    Text(AttributedString(reviews?.results[1].content ?? ""))
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            https.fetchDetailsMovieId2(id:id!, completion:{ json in
                movie = json
                self.https.fetchReviewsMoviesTMDB(id: id!, completion: {
                    reviews in self.reviews = reviews
                    self.https.fetchSimilarMoviesTMDB(id: id!, completion: {
                        similar in self.similar = similar
                    })
                })
            })
        })
    }
}

#Preview {
    SwiftUIViewDetails()
}

