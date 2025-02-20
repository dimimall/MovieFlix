//
//  SwiftUIViewDetails.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 17/2/25.
//

import SwiftUI

struct LessonDetailsViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<LessonDetailsViewControllerWrapper>) -> UIViewController {
        let viewController = ViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LessonDetailsViewControllerWrapper>) {}
}

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
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(similar?.results[0].backdrop_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 80, height: 80)
                                
                                Text("\(similar?.results[0].title ?? "")")
                                StarsView(rating: similar?.results[0].vote_average as? CGFloat ?? 2.6, maxRating: 10)
                                
                            }
                            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(similar?.results[1].backdrop_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 80, height: 80)
                                
                                Text("\(similar?.results[1].title ?? "")")
                                StarsView(rating: similar?.results[1].vote_average as? CGFloat ?? 2.6, maxRating: 10)
                                
                            }
                        }
                    }
                }
                
                Section {
                    Text("Movie Reviews")
                    ScrollView(.horizontal) {
                        LazyHStack{
                            if ((reviews?.results.count) ?? 0 > 0) {
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(reviews?.results[0].author_details?.avatar_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.red
                                    }
                                    .frame(width: 80, height: 80)
                                    
                                    Text("\(reviews?.results[0].author ?? "")")
                                    StarsView(rating: reviews?.results[0].author_details?.rating as? Double ?? 2.6, maxRating: 10)
                                    
                                }
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(reviews?.results[1].author_details?.avatar_path ?? "9CWvjeawj9rYRFasyrNjVsqhR48.jpg")")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.red
                                    }
                                    .frame(width: 80, height: 80)
                                    
                                    Text("\(reviews?.results[1].author ?? "")")
                                    StarsView(rating: reviews?.results[1].author_details?.rating as? Double ?? 0.0, maxRating: 10)
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

