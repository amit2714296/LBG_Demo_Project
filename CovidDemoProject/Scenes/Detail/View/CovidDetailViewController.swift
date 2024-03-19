//
//  CovidDetailViewController.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 18/03/24.
//

import UIKit

class CovidDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var lblLastUpdate: UILabel!
    @IBOutlet var lblConfirmCases: UILabel!
    @IBOutlet var lblDeathCases: UILabel!

    // MARK: - Variables
    
    var covidDetail: CovidDataList?
    
    /// ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Covid Cases Detail"
        setupUI()
    }
    
    private func setupUI() {
        lblLastUpdate.text = "Last updated date: " + (covidDetail?.lastUpdate ?? "")
        lblConfirmCases.text = covidDetail?.confirmed
        lblDeathCases.text = covidDetail?.deaths
    }
}


