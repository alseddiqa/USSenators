//
//  SenatorCell.swift
//  USSenators
//
//  Created by Abdullah Alseddiq on 1/14/21.
//

import UIKit

class SenatorCell: UITableViewCell {

    @IBOutlet var departmentLabel: UILabel!
    @IBOutlet var partyLabel: UILabel!
    @IBOutlet var senatorProfileImage: UIImageView!
    @IBOutlet var sentatorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        senatorProfileImage.layer.cornerRadius = 50
        senatorProfileImage.layer.cornerRadius = 50
        senatorProfileImage.layer.borderWidth = 2.0
        senatorProfileImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        senatorProfileImage.layer.masksToBounds = true
    }

}

extension UIView{
    
    //MARK: - Corner Radius
    @IBInspectable
    var cornerRadius : CGFloat {
        get{
            return layer.cornerRadius
        }
        
        set{
            layer.cornerRadius = newValue
        }
    }
    
    func setShadow(color: UIColor = .black, radius: CGFloat = 7 , opacity: Float = 0.7 , offset: CGSize  = .zero , masksToBounds: Bool = true) {
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.masksToBounds = masksToBounds
    }
}
