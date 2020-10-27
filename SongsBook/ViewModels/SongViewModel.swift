//
//  SongViewModel.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 26.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class SongViewModel: ObservableObject {
    
    @Published var songs = [Song]()
    
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    let url = "gs://songbook-3a927.appspot.com/songBody/Indescribable – Chris Tomlin.txt"
    
    func fetchSongs() {
        db.collection("songs").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.songs = documents.compactMap { (queryDocumentSnapshot) -> Song? in
                return try? queryDocumentSnapshot.data(as: Song.self)
            }
        }
    }
}
