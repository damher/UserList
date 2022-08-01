//
//  UsersViewController.swift
//  UserList
//
//  Created by Mher Davtyan on 28.07.22.
//

import UIKit
import UIScrollView_InfiniteScroll

protocol UsersViewControllerDelegate: AnyObject {
    func didSelectRow(at indexPath: IndexPath)
    func fetchNewDataRequested()
}

class UsersViewController: BaseViewController {

    // MARK: View
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    // MARK: Properties
    
    weak var delegate: UsersViewControllerDelegate?
    
    var isLastDataFetched: Bool = false
    
    var allowInfiniteScroll: Bool = false {
        didSet {
            if allowInfiniteScroll {
                tableView.addInfiniteScroll { [weak self] _ in
                    self?.delegate?.fetchNewDataRequested()
                    self?.tableView.setShouldShowInfiniteScrollHandler({ _ in !(self?.isLastDataFetched ?? false) })
                }
            }
        }
    }
    
    var dataSource: [UserViewModel] = [] {
        didSet {
            if dataSource.isEmpty {
                state = .empty
            } else {
                state = .populated
                reloadTableView()
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmptyView()
        tableView.register(UserTableCell.name)
    }
    
    override func setPopulatedView() {
        emptyView.isHidden = true
        tableView.isHidden = false
    }
    
    override func setEmptyView() {
        emptyView.isHidden = false
        tableView.isHidden = true
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.finishInfiniteScroll()
            self.tableView.reloadData()
        }
    }
    
    private func setupEmptyView() {
        emptyView.isHidden = true
        emptyLabel.text = "No result"
    }
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.name, for: indexPath) as! UserTableCell
        cell.setData(dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(at: indexPath)
    }
}
