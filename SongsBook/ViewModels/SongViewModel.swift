////
////  SongViewModel.swift
////  SongsBook
////
////  Created by Daniel Yamrak on 26.10.2020.
////  Copyright © 2020 DanielYarmak. All rights reserved.
////
//
//import FirebaseFirestore
//import FirebaseStorage
//import FirebaseFirestoreSwift
//
//
//class SongViewModel: ObservableObject {
//
//    @Published var songs = [Song]()
//
//    private let db = Firestore.firestore()
//
//    func fetchSongsAnother() {
//        db.collection("songs").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents: \(error.debugDescription)")
//                return
//            }
//
//            self.songs = documents.compactMap { (queryDocumentSnapshot) -> Song? in
//                return try? queryDocumentSnapshot.data(as: Song.self)
//            }
//        }
//    }
//}
