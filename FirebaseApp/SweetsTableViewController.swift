//
//  SweetsTableViewController.swift
//  FirebaseApp
//
//  Created by joão gabriel on 02/05/17.
//  Copyright © 2017 bepid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SweetsTableViewController: UITableViewController {
    
    var dbRef:FIRDatabaseReference!
    var sweets = [Sweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("sweet-items")
        
        startObservingDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func startObservingDB() {
        
        dbRef.observe(.value, with: { (snapshot) in
            var newSweets = [Sweet]()
            
            for sweet in snapshot.children{
                let sweetObject = Sweet(snapshot: sweet as! FIRDataSnapshot)
                newSweets.append(sweetObject)
            }
            
            self.sweets = newSweets
            self.tableView.reloadData()
            
        }) { (error) in
            print("\(error.localizedDescription)")
        }
    }
    
    
    @IBAction func addSweet(_ sender: Any) {
        
        let sweetAlert = UIAlertController(title: "New Sweet", message: "Enter your Sweet", preferredStyle: .alert)
        
        sweetAlert.addTextField { (textField) in
            textField.placeholder = "Your sweet"
        }
        
        sweetAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            if let sweetContent = sweetAlert.textFields?.first?.text{
                let sweet = Sweet(content: sweetContent, addedByUser: "Gabriel")
                
                let sweetRef = self.dbRef.child(sweetContent.lowercased())
                
                sweetRef.setValue(sweet.toAnyObject())
            }
        }))
        
        self.present(sweetAlert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let sweet = sweets[indexPath.row]
        cell.detailTextLabel?.text = sweet.addedByUser
        
        return cell
    }
}
