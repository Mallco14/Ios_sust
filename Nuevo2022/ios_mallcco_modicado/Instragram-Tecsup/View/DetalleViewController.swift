//
//  DetalleViewController.swift
//  Instragram-Tecsup
//
//  Created by youlserf on 21/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

class DetalleViewController: UIViewController {
    var idPost: String?
    var titlePost: String?
    var descriptionPost: String?
    var imagePost: String?
    
    var db = Firestore.firestore()
    
    var product: Post?
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var txtPName: UITextField!
    @IBOutlet weak var txtPDescription: UITextField!
    
    // Propiedades y métodos de la clase aquí
    override func viewDidLoad() {
        super.viewDidLoad()
        print(product!.id_document)
        writeCurrentProduct()
        
    }
    
    func writeCurrentProduct(){
        txtPName.text = product!.title
        txtPDescription.text = product!.description
        imageFromUrl(url: product!.image)
    }
    
    func imageFromUrl(url: String){
        let imageURL = URL(string: url)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            imageProduct.image = UIImage(data: imageData)
            imageProduct.contentMode = .scaleAspectFill
        }
    }
    
    
    @IBAction func btnUpdateProduct(_ sender: UIButton) {
        db.collection("posts").document(product!.id_document).setData([
            "userId": Auth.auth().currentUser?.uid ?? "no-id",
            "title": txtPName.text!,
            "description": txtPDescription.text!,
            "image": product!.image]
        )
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteProduct(_ sender: UIButton) {
        db.collection("posts").document(product!.id_document).delete { error in
                if let error = error {
                    print("Error removing document: \(error)")
                } else {
                    print("Document successfully removed!")
                }
            }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onTapBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
