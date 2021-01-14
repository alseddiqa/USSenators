//
//  SenatorDetailViewController.swift
//  USSenators
//
//  Created by Abdullah Alseddiq on 1/14/21.
//

import UIKit

class SenatorDetailViewController: UIViewController {

    //Senator object that will be set wheneve a cell is clicked on from the displayed list
    var senator: Object!
    
    //Declaring view outlets
    @IBOutlet var senatorProfileImage: UIImageView!
    @IBOutlet var senatorNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var wbesiteButton: UIButton!
    @IBOutlet var contactInfoStackView: UIStackView!
    @IBOutlet var imageBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    // Set up the view with information about the senator
    func setUpView() {
        self.navigationItem.title = senator.person.firstname + " " + senator.person.lastname
        senatorNameLabel.text = senator.person.name
        wbesiteButton.setTitle(senator.website, for: .normal)
        
        addressLabel.text = senator.extra.address
        dateOfBirthLabel.text = "Born in " + senator.person.birthday
        phoneNumLabel.text = senator.extra.fax
        genderLabel.text = senator.person.gender.rawValue
        
        if senator.party.rawValue == "Democrat" {
            senatorProfileImage.image = #imageLiteral(resourceName: "democrat")
        }
        else if senator.party.rawValue == "Republican" {
            senatorProfileImage.image = #imageLiteral(resourceName: "republican")
        }
        
        senatorProfileImage.layer.cornerRadius = 50
        senatorProfileImage.layer.borderWidth = 2.0
        senatorProfileImage.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        senatorProfileImage.layer.masksToBounds = true
        
        contactInfoStackView.layer.borderWidth = 2.0
        contactInfoStackView.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        imageBackView.layer.borderWidth = 2.0
        imageBackView.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)

    }
    
    // A function to open senator's website in Safari
    @IBAction func openWebsite(_ sender: UIButton) {
        if let web = sender.titleLabel?.text {
            guard let url = URL(string: web) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
}
