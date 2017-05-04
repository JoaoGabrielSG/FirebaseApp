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

    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("sweet-items")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
