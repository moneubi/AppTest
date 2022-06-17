//
//  UserListVC.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import UIKit
import CoreData

private let CellId = "UserCell"

class UserListVC: UIViewController {
    private var tableView = UITableView()
    private let screenSize = UIScreen.main.bounds
    
    var indexPa: IndexPath!
    
    private var utilisateur: Utilisateur!
    
    lazy var viewModel = {
        UserListViewModel()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
        
        if Common.isUpdated{
            
            Common.utilisateurs[Common.index_row - 1].first_name = Common.first_name
            Common.utilisateurs[Common.index_row - 1].last_name = Common.last_name
            
            indexPa = IndexPath(item: Common.index_row - 1, section: 0)
            
            self.tableView.reloadRows(at: [indexPa], with: .automatic)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "col_background")
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        self.title = "User Managment App"
        
        self.tableView = TableViewUtilities.init().createtableView(x: 10, y: 10, width: screenSize.width - 20, height: screenSize.height - 20, rowHeight: 80)
        tableView.register(UserCell.self, forCellReuseIdentifier: CellId)
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        initViewModel()
    }
    
    func initViewModel() {
        let child = SpinnerUtilities()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        viewModel.getUtilisateurs()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
}

extension UserListVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.userCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! UserCell

        var cellVM = viewModel.getCellViewModel(at: indexPath)
        if Common.isUpdated && indexPa == indexPath {
            cellVM.first_name = Common.first_name
            cellVM.last_name = Common.last_name
            cellVM.avatar = Common.avatar
            cellVM.id = Common.id
            cellVM.email = Common.email
            Common.isUpdated.toggle()
            Common.email = ""
            Common.first_name = ""
            Common.last_name = ""
            Common.avatar = ""
            Common.id = 0
            Common.index_row = 0
        }
        cell.setUser(utilisateur: cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        utilisateur = Common.utilisateurs[indexPath.row]
        let vc = DetailUserVC()
        vc.utilisateur = utilisateur
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailUserVC{
            destination.utilisateur = utilisateur
        }
    }
}
