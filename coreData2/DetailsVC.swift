//
//  DetailsVC.swift
//  coreData2
//
//  Created by ihlas on 20.01.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var artistText: UITextField!
    @IBOutlet var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Regocnizer
        
        let gestureRecognizer = UIGestureRecognizer(target: self , action: #selector(hideKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        
        let imageTapRegogniser = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRegogniser)
        
        
        
        
        
        
    }
    @objc func selectImage(){
     let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true //bunu yapmak zorunda değilsin
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //seçtikten sonra ne olacak
        imageView.image = info[.originalImage] as? UIImage //kullanıcı galery igidiypr
        self.dismiss(animated: true, completion: nil)
    
    
    
        
    }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
        
    }
    
    
    
    
    @IBAction func butonPressed(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newPaintings = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPaintings.setValue(nameText.text , forKey: "name")
        newPaintings.setValue(artistText.text, forKey: "artist")
        
        if let year = Int(yearText.text!){
            newPaintings.setValue(year, forKey: "year")
        }
        newPaintings.setValue(UUID(), forKey: "id")
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newPaintings.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("success")
            
        }catch{
            print("error")
        }
        
    }
    
    
}
