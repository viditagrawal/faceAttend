//
//  customCell.swift
//  faceLogin
//
//  Created by Vidit Agrawal on 4/14/19.
//  Copyright © 2019 Vidit Agrawal. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

@IBOutlet weak var backgroundImage: UIImageView!
@IBOutlet weak var cancelButton: UIButton!
@IBOutlet weak var contactButton: UIButton!
@IBOutlet weak var emailLabel: UILabel!
@IBOutlet weak var personname: UILabel!

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    self.backgroundView?.backgroundColor = .white
}
  
func config(name: String, image: UIImage, email: String){
    personname.text = name
    backgroundImage.image = image
    emailLabel.text = email
    cancelButton.isHidden = true
    emailLabel.isHidden = true
}
@IBAction func hideEmail(_ sender: Any) {
     
    backgroundImage.isHidden = false
    contactButton.isHidden = false
    personname.isHidden = false
      
    cancelButton.isHidden = true
    emailLabel.isHidden = true
}
 
@IBAction func buttonPressed(_ sender: Any) {
    backgroundImage.isHidden = true
    contactButton.isHidden = true
    personname.isHidden = true
    
    cancelButton.isHidden = false
    emailLabel.isHidden = false
    }
}
