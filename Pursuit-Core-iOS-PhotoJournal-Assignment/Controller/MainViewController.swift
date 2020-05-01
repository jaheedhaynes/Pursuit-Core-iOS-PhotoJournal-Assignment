//
//  ViewController.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 1/24/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit
import AVFoundation
import DataPersistence

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataPersistance = DataPersistence<Image>(filename: "images.plist")
    
    private var images = [Image](){
        didSet{
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .purple
        collectionView.dataSource = self
        collectionView.delegate = self
        loadImages()
    }
 
    private func loadImages(){
        do{
            images = try dataPersistance.loadItems()
        }catch{
            print("\(error.localizedDescription)")
        }
    }
    
    //--------------------------------------------
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        showAddImageVC()
    }
    
    private func showAddImageVC(){
        guard let imageVC = storyboard?.instantiateViewController(identifier: "AddImageViewController") as? AddImageViewController else {
            fatalError("could not segue to AddImageViewController")
        }
        imageVC.delegate = self 
        present(imageVC, animated: true)
    }
    //--------------------------------------------

    
    
    private func appendImage(){
            do{
                images = try dataPersistance.loadItems()
            }catch{
                print("Error: \(error.localizedDescription)")
            }
    }
}

    

//---------------------------------------------------------------------
// MARK: EXTENSIONS

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionViewCell else {
            fatalError("could not downcast to Journal Cell")
        }
        let image = images[indexPath.row]
        cell.configureCell(image)
        return cell
    }
    
    
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
//        let itemWidth: CGFloat = maxWidth * 0.80
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
}

extension MainViewController: SavePhotoDelegate{
    func didSave(photo: Image) {
        self.images.append(photo)
    }
    
    
}
