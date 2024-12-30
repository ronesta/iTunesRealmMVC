//
//  NetworkManager.swift
//  iTunesRealmMVC
//
//  Created by Ибрагим Габибли on 30.12.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    var counter = 1

    func fetchAlbums(albumName: String, completion: @escaping ([Album]?, Error?) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let term = albumName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?term=\(term)&entity=album&attribute=albumTerm"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NetworkError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }

            guard let data else {
                print("No data")
                completion(nil, NetworkError.noData)
                return
            }

            do {
                let albums = try JSONDecoder().decode(PostAlbums.self, from: data).results
                completion(albums, nil)
                print("Load data \(self.counter)")
                self.counter += 1
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
}
