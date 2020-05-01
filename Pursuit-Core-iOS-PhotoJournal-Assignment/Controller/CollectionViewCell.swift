//
//  CollectionViewCell.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 4/29/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: AnyObject {
    func cellOptionPressed(photoCell: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var delegate: CollectionCellDelegate?
    var index: IndexPath?
    
    public func configureCell(_ cell: Image){
        guard let image = UIImage(data: cell.imageData) else{
            return
        }
        imageView.image = image
        dateLabel.text = cell.date.description
        captionLabel.text  = cell.description
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        delegate?.cellOptionPressed(photoCell: self)
    }
    
    
}
