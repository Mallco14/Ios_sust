//
//  HomeViewController.swift
//  Instragram-Tecsup
//
//  Created by MAC37 on 18/11/22.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var db = Firestore.firestore()
    
    var posts:  [Post] = [Post]()
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        getPosts()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            let destinationVC = segue.destination as! DetalleViewController
            destinationVC.idPost = selectedPost?.id_document
            destinationVC.titlePost = selectedPost?.title
            destinationVC.descriptionPost = selectedPost?.description
            destinationVC.imagePost = selectedPost?.image
            destinationVC.product = selectedPost
        }
    }
    
    
    @IBAction func showDetail(_ sender: UIButton) {
        // Obtiene el índice de la celda tocada
                guard let indexPath = tableView.indexPath(for: sender.superview?.superview as! UITableViewCell) else {
                    return
                }

                // Almacena el elemento del array de datos correspondiente en una propiedad para poder acceder a él desde la función prepare(for:sender:)
                selectedPost = posts[indexPath.row]

                // Inicia el segue con el identificador "segueDetail"
                performSegue(withIdentifier: "segueDetail", sender: self)
    }
    
    func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getPosts() {
        db.collection("posts").getDocuments { querySnapshot, error in
            if let documents = querySnapshot?.documents {
                for document in documents {
                    let data = document.data()
                    
                    let newPost = Post(id_document: document.documentID as? String ?? ""
                                       , user_id: data["userId"] as? String ?? "", title: data["title"] as? String ?? "", description: data["description"]  as? String ?? "", image: data["image"] as? String ?? "")
                    self.posts.append(newPost)
                }
                self.tableView.reloadData()
            }
        }
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.titlePost.text = posts[indexPath.row].title
        cell.descriptionPost.text = posts[indexPath.row].description
        
        let imageURL = URL(string: posts[indexPath.row].image)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.imagePost.image = UIImage(data: imageData)
            cell.imagePost.contentMode = .scaleAspectFill
        }
        return cell
    }
    
}
