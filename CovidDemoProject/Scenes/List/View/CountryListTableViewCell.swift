//
//  CountryListTableViewCell.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var lblStateName: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCell(model: Any) {
        if let object = model as? CovidDataList {
            lblCountryName.text = "Country Name : " + ((object.countryRegion == "" ? "NA" : object.countryRegion) ?? "")
        }
        
        if let object = model as? CovidDataList {
            lblLat.text = "Latitude : \(object.lat == "" ? "NA" : object.lat ?? "")"
        }
        
        if let object = model as? CovidDataList {
            lblLang.text = "Longitude : \(object.long == "" ? "NA" : object.long ?? "")"
        }
        
        if let object = model as? CovidDataList {
            lblStateName.text = "State Name : \(object.provinceState == "" ? "NA" : object.provinceState ?? "")"
        }
    }
}
