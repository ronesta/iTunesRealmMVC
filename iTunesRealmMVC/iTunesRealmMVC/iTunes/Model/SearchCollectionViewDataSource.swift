//
//  SearchCollectionViewDataSource.swift
//  iTunesRealmMVC
//
//  Created by Ибрагим Габибли on 08.01.2025.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var albums = [RealmAlbum]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let album = albums[indexPath.item]

        guard let imageData = StorageManager.shared.fetchImageData(forImageId: Int(album.artistId)),
              let image = UIImage(data: imageData) else {
            return cell
        }

        cell.configure(with: album, image: image)
        return cell
    }
}
