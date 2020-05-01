//
//  AddImageViewController.swift
//  Pursuit-Core-iOS-PhotoJournal-Assignment
//
//  Created by Jaheed Haynes on 4/29/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit
import AVFoundation
import DataPersistence

protocol SavePhotoDelegate: AnyObject {
    func didSave(photo: Image)
}

class AddImageViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var images: Image!
    
    weak var delegate: SavePhotoDelegate?
    
    private var imagePicker = UIImagePickerController()
    
    private let dataPersistance = DataPersistence<Image>(filename: "images.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
       
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIButton) {
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        saveButton.isEnabled = true
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let image = photoImage.image else {
            return
        }
        
        // the size to resize image
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspect ratio of the image
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        // resize image
        let resized = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        guard let photoData = resized.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        images = Image(imageData: photoData, date: Date(), description: textView.text)
        delegate?.didSave(photo: images)
        do {
            try dataPersistance.createItem(images)
        } catch {
            print("saving error: \(error)")
        }
        dismiss(animated: true)
    }
    

}

//---------------------------------------------------------------------
// MARK: EXTENSIONS

extension UIImage{
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
            let size = CGSize(width: width, height: height)
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { (context) in
                self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        photoImage.image = image
        dismiss(animated: true)
    }
}
