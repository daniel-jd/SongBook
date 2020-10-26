//
//  SongViewModel.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 26.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SongViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    private var db = Firestore.firestore()
    
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
