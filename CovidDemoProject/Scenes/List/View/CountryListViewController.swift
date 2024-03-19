//
//  CountryListViewController.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import UIKit

class CountryListViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!

    // MARK: - Variables
    
    var dataSource = CovidListDatasource()
    private var viewModel: CovidListViewModel!
    
    /// ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Covid Country List"
        viewModel = CovidListViewModel(dataSource: dataSource)
        bindViewModel()
    }
    
    /// Method to fetch covid list with a web service
    /// Update tableview on datsource update
    /// show activity laoder on web service call
    
    private func bindViewModel() {
        viewModel?.setupLoader = { [weak self] loader in
            loader == true ? self?.showLoader() : self?.hideLoader()
        }
        
        viewModel?.onError = { [weak self] message in
            self?.showAlertWith(message: message)
        }
        
        tableView.dataSource = dataSource
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchCovidList()
    }
}

/// Tableview data source methods
/// Called on datasource change

class CovidListDatasource: GenericDataSource<CovidDataList>, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CountryListTableViewCell.self, for: indexPath)
        cell.updateCell(model: data.value[indexPath.row])
        return cell
    }
}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CovidDetailViewController.instantiate(fromAppStoryboard: .Main)
        vc.covidDetail = viewModel.dataSource?.data.value[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
