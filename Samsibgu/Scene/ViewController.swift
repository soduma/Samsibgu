//
//  ViewController.swift
//  Samsibgu
//
//  Created by 장기화 on 2022/05/04.
//

//import UIKit
//import SnapKit
//
//class ViewController: UIViewController {
//    let networkManager = NetworkManager()
//    let keyword = "se"
//    var locationList: [MetaWeatherAPI] = []
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
////        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: 300, height: 100)
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.delegate = self
//        view.dataSource = self
//        view.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Local Weather"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        
//        Task {
//            await fetch()
//            layout()
//        }
//    }
//
//    private func fetch() async {
//        let data = await networkManager.fetchLocation(keyword: keyword)
//        
//        switch data {
//        case .success(let result):
//            locationList = result
//            print(result)
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }
//}
//
//extension ViewController {
//    func layout() {
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .blue
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//}
//
//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return locationList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
//        cell.setSOME(title: locationList[indexPath.row].title)
//        return cell
//    }
//}
