//
//  ContactVC.swift
//  faceLogin
//
//  Created by Vidit Agrawal on 4/14/19.
//  Copyright © 2019 Vidit Agrawal. All rights reserved.
//

import UIKit

class ContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let names = ["Jainam", "Ritvik", "Siya", "Varun", "Sid", "Vidit"]
    let emails = ["jainam@gmail.com", "ritvik@gmail.com", "siya@gmail.com", "varun@gmail.com", "sid@gmail.com", "vidit@gmail.com"]
    let images = ["jainam", "ritvik", "siya", "varun","sid", "vidit"]

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "studentCell") as? customCell?
        cell1!?.config(name: names[indexPath.row], image: UIImage(named: images[indexPath.row])!, email: emails[indexPath.row])
        return cell1 as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
