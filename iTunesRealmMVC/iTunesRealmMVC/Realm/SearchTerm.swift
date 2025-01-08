//
//  SearchTerm.swift
//  iTunesRealmMVC
//
//  Created by Ибрагим Габибли on 08.01.2025.
//

import Foundation
import RealmSwift

final class SearchTerm: Object {
    @objc dynamic var term: String = ""

    override static func primaryKey() -> String? {
        return "term"
    }
}
