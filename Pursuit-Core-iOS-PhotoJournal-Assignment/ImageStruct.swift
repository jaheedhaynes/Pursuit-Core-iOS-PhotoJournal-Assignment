//
//  ImageStruct.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 1/26/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation

struct Image: Codable & Equatable {
    let imageData: Data
    let date: Date
    var description: String
    let identifier = UUID().uuidString
    
}
