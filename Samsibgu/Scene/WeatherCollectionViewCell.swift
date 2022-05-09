//
//  WeatherCollectionViewCell.swift
//  Samsibgu
//
//  Created by 장기화 on 2022/05/04.
//

import UIKit
import SnapKit
import Kingfisher

class WeatherCollectionViewCell: UITableViewCell {
    static let identifier = "WeatherCollectionViewCell"
    
    private lazy var localeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.contentMode = .center
        return view
    }()
    
    private lazy var todayView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tomorrowView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stateNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var tempertureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var weatherImageView2: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stateNameLabel2: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var tempertureLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var humidityLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [localeLabel, stackView]
            .forEach { contentView.addSubview($0) }
        
        localeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(localeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        [todayView, tomorrowView]
            .forEach { stackView.addArrangedSubview($0) }
        
        todayView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        tomorrowView.snp.makeConstraints {
            $0.top.equalTo(todayView)
            $0.leading.equalTo(todayView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        [weatherImageView, stateNameLabel, tempertureLabel, humidityLabel]
            .forEach { todayView.addSubview($0) }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(64)
        }
        
        stateNameLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView).offset(8)
            $0.leading.equalTo(weatherImageView.snp.trailing).offset(12)
        }
        
        tempertureLabel.snp.makeConstraints {
            $0.top.equalTo(stateNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(stateNameLabel)
        }
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(tempertureLabel)
            $0.leading.equalTo(tempertureLabel.snp.trailing).offset(12)
        }
        
        [weatherImageView2, stateNameLabel2, tempertureLabel2, humidityLabel2]
            .forEach { tomorrowView.addSubview($0) }
        
        weatherImageView2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(64)
        }
        
        stateNameLabel2.snp.makeConstraints {
            $0.top.equalTo(weatherImageView2).offset(8)
            $0.leading.equalTo(weatherImageView2.snp.trailing).offset(12)
        }
        
        tempertureLabel2.snp.makeConstraints {
            $0.top.equalTo(stateNameLabel2.snp.bottom).offset(12)
            $0.leading.equalTo(stateNameLabel2)
        }
        
        humidityLabel2.snp.makeConstraints {
            $0.top.equalTo(tempertureLabel2)
            $0.leading.equalTo(tempertureLabel2.snp.trailing).offset(12)
        }
    }
    
    func setTitle(_ title: String) {
        localeLabel.text = title
    }
    
    func setToday(weatherList: ConsolidatedWeather) {
        let imageAbbr = weatherList.weatherStateAbbr
        guard let imageURL = URL(string: "https://www.metaweather.com/static/img/weather/png/\(imageAbbr).png") else { return }
        weatherImageView.kf.setImage(with: imageURL)
        
        stateNameLabel.text = weatherList.weatherStateName
        tempertureLabel.text = "\(String(Int(weatherList.temp)))℃"
        humidityLabel.text = "\(String(weatherList.humidity))%"
    }
    
    func setTomorrow(weatherList: ConsolidatedWeather) {
        let imageAbbr = weatherList.weatherStateAbbr
        guard let imageURL = URL(string: "https://www.metaweather.com/static/img/weather/png/\(imageAbbr).png") else { return }
        weatherImageView2.kf.setImage(with: imageURL)
        stateNameLabel2.text = weatherList.weatherStateName
        tempertureLabel2.text = "\(String(Int(weatherList.temp)))℃"
        humidityLabel2.text = "\(String(weatherList.humidity))%"
    }
}
