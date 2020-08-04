//
//  ViewController.swift
//  ParsingJSON-URLSession
//
//  Created by casandra grullon on 8/4/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    enum Section {
        case primary
    }
    @IBOutlet weak var tableview: UITableView!
    
    let apiClient = APIClient()
    
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Citi Bike Stations"
        fetchData()
        configureDataSource()
        tableview.delegate = self
    }
    private func fetchData() {
        apiClient.fetchData { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let stations):
                DispatchQueue.main.async {
                    self?.updateSnapshot(with: stations)
                }
            }
        }
    }
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableview, cellProvider: { (tableView, indexPath, station) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = station.name
            cell.detailTextLabel?.text = "Bike Capacity: \(station.capacity)"
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    private func updateSnapshot(with stations: [Station]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stations, toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
extension StationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
class DataSource: UITableViewDiffableDataSource<StationsViewController.Section, Station> {
    
}
