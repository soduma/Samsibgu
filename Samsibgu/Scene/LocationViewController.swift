//
//  LocationViewController.swift
//  Samsibgu
//
//  Created by 장기화 on 2022/05/04.
//

import UIKit
import SnapKit

class LocationViewController: UIViewController {
    let keyword = "se"
    let networkManager = NetworkManager()
    var locationList: [LocationSearchResponse] = []
    var consolidatedWeatherList: [ConsolidatedWeather] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(WeatherCollectionViewCell.self, forCellReuseIdentifier: WeatherCollectionViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetch()
            await fetch2()
            layout()
        }
    }

    private func fetch() async {
        let data = await networkManager.fetchLocationSearch(keyword: keyword)
        
        switch data {
        case .success(let result):
            locationList = result
            print(result)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func fetch2() async {
        let number = String(locationList[0].woeid)
        let data = await networkManager.fetchLocation(woeid: number)
        
        switch data {
        case .success(let result):
            consolidatedWeatherList = result.consolidatedWeather
            print(result.consolidatedWeather)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension LocationViewController {
    func layout() {
        title = "Local Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UITableViewCell() }
//        cell.setTitle(locationList[indexPath.row].title)
        cell.setToday(title: locationList[indexPath.row].title, weatherList: consolidatedWeatherList[indexPath.row])
//        cell.setContent(weatherList: consolidatedWeatherList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        locationList.count
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        let abc = NSMutableAttributedString(s)
//        let header = UILabel()
//        header.font = .systemFont(ofSize: 20, weight: .bold)
//        header.text = locationList[section].title
//        return head
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerLabel = UILabel()
//        headerLabel.frame = CGRect(x: 20, y: 4, width: 320, height: 20)
//        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
//        headerLabel.text = locationList[section].title
//        headerLabel.textColor = .label
//
//        let headerView = UIView()
//        headerView.backgroundColor = .systemBackground
//        headerView.addSubview(headerLabel)
//
//        return headerView
//    }
}
