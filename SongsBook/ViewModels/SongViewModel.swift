//
//  SongViewModel.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 26.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

class SongViewModel: ObservableObject {
    
    @Published var songs = [Song]()
    
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    let url = "gs://songbook-3a927.appspot.com/songBody/Indescribable – Chris Tomlin.txt"
    
    func readFile() {
        let fileUrlProject = Bundle.main.path(forResource: "Oceans", ofType: "txt")
        var readString = ""
        do {
            readString = try String(contentsOfFile: fileUrlProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to read from file project")
            print(error)
        }
        print(readString)
    }
    
    func fetchSongs() {
        db.collection("songs").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents: \(error.debugDescription)")
                return
            }
            
            // MARK: - Trying to get url path to a songBody
            
            self.storage.child("songBody/Indescribable – Chris Tomlin.txt").downloadURL { (url, error) in
                guard let url = url, error == nil else {
                    print(error.debugDescription)
                    return
                }
                print("path: \(url)")
            }
            
            
            self.songs = documents.compactMap { (queryDocumentSnapshot) -> Song? in
                return try? queryDocumentSnapshot.data(as: Song.self)
            }
        }
    }
}
