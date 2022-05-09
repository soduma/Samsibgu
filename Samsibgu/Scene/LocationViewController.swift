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
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Today"
        return label
    }()
    
    private lazy var tomorrowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Tomorrow"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [todayLabel, tomorrowLabel])
        view.backgroundColor = .systemYellow
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.allowsSelection = false
        view.delegate = self
        view.dataSource = self
        view.register(WeatherCollectionViewCell.self, forCellReuseIdentifier: WeatherCollectionViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            layout()
            await fetch()
            await fetch2()
            tableView.reloadData()
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
        for i in 0...locationList.count - 1 {
            let woeid = String(locationList[i].woeid)
            let data = await networkManager.fetchLocation(woeid: woeid)
            switch data {
            case .success(let result):
                consolidatedWeatherList = result.consolidatedWeather
                print("🥵\(consolidatedWeatherList)")
                tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension LocationViewController {
    private func layout() {
        title = "Local Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
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
        cell.setTitle(locationList[indexPath.row].title)
        cell.setToday(weatherList: consolidatedWeatherList[0])
        cell.setTomorrow(weatherList: consolidatedWeatherList[1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
