//
//  StorageManager.swift
//  iTunesRealmMVC
//
//  Created by Ибрагим Габибли on 30.12.2024.
//

import Foundation
import RealmSwift

final class StorageManager: NSObject {
    static let shared = StorageManager()

    private override init() {
        super.init()
    }

    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    // swiftlint:disable:next function_parameter_count
    public func createOrUpdateAlbum(artistId: Int,
                                    artistName: String,
                                    collectionName: String,
                                    artworkUrl100: String,
                                    collectionPrice: Double,
                                    imageData: Data?,
                                    term: String) {
        let album = RealmAlbum()
        album.artistId = artistId
        album.artistName = artistName
        album.collectionName = collectionName
        album.artworkUrl100 = artworkUrl100
        album.collectionPrice = collectionPrice
        album.imageData = imageData
        album.term = term

        do {
            try realm.write {
                realm.add(album, update: .modified)
            }
        } catch {
            print("Error saving album: \(error)")
        }
    }

    func saveAlbums(_ albums: [(album: Album, imageData: Data?)], for searchTerm: String) {
        for (album, imageData) in albums {
            createOrUpdateAlbum(
                artistId: album.artistId,
                artistName: album.artistName,
                collectionName: album.collectionName,
                artworkUrl100: album.artworkUrl100,
                collectionPrice: album.collectionPrice,
                imageData: imageData,
                term: searchTerm)
        }
    }

    func saveSearchTerm(_ term: String) {
        let searchTerm = SearchTerm()
        searchTerm.term = term

        do {
            try realm.write {
                realm.add(searchTerm, update: .modified)
            }
        } catch {
            print("Failed to save search term: \(error)")
        }
    }

    func fetchAlbums(for searchTerm: String) -> [RealmAlbum] {
        let results = realm.objects(RealmAlbum.self).filter("term == %@", searchTerm).sorted(
            byKeyPath: "collectionName",
            ascending: true)
        return Array(results)
    }

    func fetchImageData(forImageId id: Int) -> Data? {
        realm.object(ofType: RealmAlbum.self, forPrimaryKey: id)?.imageData
    }

    func getSearchHistory() -> [String] {
        let results = realm.objects(SearchTerm.self)
        return results.map { $0.term }
    }
}

extension StorageManager {
    func clearAlbums() {
        do {
            try realm.write {
                realm.delete(realm.objects(RealmAlbum.self))
            }
        } catch {
            print("Failed to clear albums: \(error)")
        }
    }

    func clearHistory() {
        do {
            try realm.write {
                realm.delete(realm.objects(SearchTerm.self))
            }
        } catch {
            print("Failed to clear history: \(error)")
        }
    }
}
