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
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
//    private lazy var HStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        [firstView, secondView]
//            .forEach { stack.addArrangedSubview($0) }
//        return stack
//    }()
    
//    private lazy var VStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        return stack
//    }()
//
    private lazy var todayView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemRed
        return view
    }()
    
    private lazy var tomorrowView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .systemYellow
        return view
    }()
    
    private lazy var stateNameLabel: UILabel = {
        let label = UILabel()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [todayView, tomorrowView]
            .forEach { contentView.addSubview($0) }
        
        todayView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        [localeLabel, weatherImageView, stateNameLabel, tempertureLabel, humidityLabel]
            .forEach { todayView.addSubview($0) }
        
        localeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
        }
//        HStackView.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(localeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(72)
        }
        
        stateNameLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView).offset(8)
            $0.leading.equalTo(weatherImageView.snp.trailing).offset(12)
        }
        
        tempertureLabel.snp.makeConstraints {
            $0.top.equalTo(stateNameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(stateNameLabel)
        }
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(tempertureLabel)
            $0.leading.equalTo(tempertureLabel.snp.trailing).offset(12)
        }
        
//        layoutIfNeeded()
    }
    
//    func setTitle(_ title: String) {
//        titleLabel.text = title
//    }
    
    func setToday(title: String, weatherList: ConsolidatedWeather) {
        localeLabel.text = title
        let imageAbbr = weatherList.weatherStateAbbr
//        print(imageAbbr)
        guard let imageURL = URL(string: "https://www.metaweather.com//static/img/weather/png/\(imageAbbr).png") else { return }
        weatherImageView.kf.setImage(with: imageURL)
//        layoutIfNeeded()
        
        stateNameLabel.text = weatherList.weatherStateName
        tempertureLabel.text = "\(String(Int(weatherList.temp)))℃"
        humidityLabel.text = "\(String(weatherList.humidity))%"
        
    }
}
