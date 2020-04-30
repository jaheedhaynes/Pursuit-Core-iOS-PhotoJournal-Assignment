//
//  PersistenceHelper.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 1/26/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    //MARK: CRUD(Create, Read, Update, Delete)
    
    private var photos = [Image]()
    
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    
    //MARK: Step 1
    private func save() throws {
        
        // get url path to the file that the ImageObject will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        
        
        
        
        //MARK: Step 3
        // Photo array will be object being converted to Data
        // Use the Data object and write (save) it to documents directory
        do {
            // convert (serialize) the photos array to Data
            let data = try PropertyListEncoder().encode(photos)
            
            
            
            
            //MARK: Step 4
            // writes, saves, persist the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            
            
            
            
            
            //MARK: Step 5
            // throw error
            throw DataPersistenceError.savingError(error)
        }
    }
    
    
    
    
    // for re-ordering
    public func reorderEvents(photos: [Image]) {
        self.photos = photos
        try? save()
    }
    
    
    
    
    
    
    //MARK: Step 2
    // create - save item to documents directory
    public func create(photo: Image) throws {
        
        // append new item to the events array
        photos.append(photo)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    // read - load (retrieve) items from documents directory
    public func loadImages() throws -> [Image] {
        // we need access to the filename URL that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if file exist
        // to convert URL to String we use .path on the URL
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([Image].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        }
        else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return photos
    }
    
    
    
    // delete - remove item from documents directory
    public func delete(_ index: Int) throws {
        
        // remove the item from the events array
        photos.remove(at: index)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
