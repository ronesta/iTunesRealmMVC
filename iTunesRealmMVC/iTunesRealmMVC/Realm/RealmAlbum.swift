//
//  RealmAlbum.swift
//  iTunesRealmMVC
//
//  Created by Ибрагим Габибли on 30.12.2024.
//

import Foundation
import RealmSwift

final class RealmAlbum: Object {
    @objc dynamic var artistId: Int = 0
    @objc dynamic var artistName: String = ""
    @objc dynamic var collectionName: String = ""
    @objc dynamic var artworkUrl100: String = ""
    @objc dynamic var collectionPrice: Double = 0
    @objc dynamic var imageData: Data?
    @objc dynamic var term: String = ""

    override static func primaryKey() -> String? {
        return "artistId"
    }
}
