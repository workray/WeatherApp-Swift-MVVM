//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import UIKit
import DomainPlatform
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    var viewModel: WeatherViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: WeatherTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseID)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = WeatherViewModel.Input(initialTrigger: Driver.merge(viewWillAppear, pull),
                                           selectionTrigger: tableView.rx.itemSelected.asDriver().do(onNext: { (indexPath) in
                                            self.tableView.deselectRow(at: indexPath, animated: true)
                                           }))
        let output = viewModel.transform(input: input)
        //Bind Posts to UITableView
        output.weathers.drive(tableView.rx.items(cellIdentifier: WeatherTableViewCell.reuseID, cellType: WeatherTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
            }.disposed(by: disposeBag)
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.selectedCity
            .drive()
            .disposed(by: disposeBag)
    }
}

