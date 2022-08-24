//
//  ContentView.swift
//  MovieBrowserSwiftUI
//
//  Created by Sam LoBue on 8/10/22.
//

import SwiftUI


// Itunes Request

//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//struct ContentView: View {
//    @State private var results = [Result]()
//
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
//    }
//
//    func loadData() async {
//        guard let url = URL(string:
//            "https://itunes.apple.com/search?term=john+coltrane&entity=song") else
//            {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//        print(results)
//
//
//    }
//}


// Movie DB Request

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var original_title: String
    var release_date: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        Text("Top")
        List(results, id: \.original_title) { item in
            VStack(alignment: .leading) {
                Text(item.original_title)
                    .font(.headline)
                Text(item.release_date)
            }
        }
        .task {
            await loadData()
        }
        Text("Bottom")
    }

    func loadData() async {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "f1bba69d2f7b8e57f3db0f3c5cf16c9a"),
            URLQueryItem(name: "query", value: "Jack+Reacher")
        ]

        guard let url = components.url else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results

            }
        } catch {
            print("Invalid data")
        }
        print("results: \(results)") // Printing for debugging purposes
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
