//
//  ViewController.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 1/24/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataPersistance = PersistenceHelper(filename: "images.plist")
    
    private var images = [Image](){
        didSet{
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
 
    //--------------------------------------------
    @IBAction func addImageButtonPressed(_ sender: UIBarButtonItem) {
        addImage()
    }
    
    private func addImage(){
        guard let imageVC = storyboard?.instantiateViewController(identifier: "AddImageViewController") as? AddImageViewController else {
            fatalError("could not segue to AddImageViewController")
        }
        
        present(imageVC, animated: true)
    }
    //--------------------------------------------

    
    
    
    private func loadImages(){
        do{
            images = try dataPersistance.loadImages()
        }catch{
            print("\(error.localizedDescription)")
        }
    }
    
    


}

