//
//  UsersBaseViewController.swift
//  UserList
//
//  Created by Mher Davtyan on 28.07.22.
//

import UIKit

class UsersBaseViewController: BaseViewController {

    enum Page: Int, CaseIterable {
        case users
        case savedUsers
        
        var title: String {
            switch self {
            case .users:
                return "Users"
            case .savedUsers:
                return "Saved Users"
            }
        }
    }
    
    // MARK: View
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var searchInput: UITextField!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: Properties
    
    var viewModel: UsersBaseViewModelProtocol?
    
    private var pageViewController: UIPageViewController?
    private var pages: [UsersViewController?] = []
    
    private var selectedPage: Int = 0 {
        didSet {
            reloadUsersData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .loading
        
        setupUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setErrorView(_ error: Error?) {
        displayActivityIndicator(false, to: nil, indicatorColor: nil, backgroundColor: nil)
        showErrorMessage(error)
    }
    
    override func setPopulatedView() {
        displayActivityIndicator(false, to: nil, indicatorColor: nil, backgroundColor: nil)
    }
    
    override func setLoadingView() {
        displayActivityIndicator(true, to: view, indicatorColor: nil, backgroundColor: nil)
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pageViewController = segue.destination as? UIPageViewController
    }
    
    // MARK: ViewModel
    private func setupViewModel() {
        viewModel = ServiceLocator.instance.resolve(UsersBaseViewModelProtocol.self)
        
        viewModel?.errorAction = { [weak self] error in
            self?.state = .error(error)
            self?.reloadUsersData()
        }
            
        viewModel?.propertyChanged = { [weak self] path in
            
            guard let strongSelf = self else { return }
            
            switch path {
            case \UsersBaseViewModelProtocol.users:
                strongSelf.pages[Page.users.rawValue]?.isLastDataFetched = strongSelf.viewModel?.isLastDataFetched ?? false
                strongSelf.state = .populated
                
                if strongSelf.viewModel?.searchText?.isEmpty ?? true {
                    strongSelf.reloadUsersData(for: .users)
                } else {
                    strongSelf.reloadUsersData()
                }
            case \UsersBaseViewModelProtocol.savedUsers:
                strongSelf.reloadUsersData(for: .savedUsers)
            case \UsersBaseViewModelProtocol.searchText:
                strongSelf.reloadUsersData()
            default:
                break
            }
        }
        
        viewModel?.loadData()
        viewModel?.loadDefaultData()
    }
    
    private func reloadUsersData() {
        guard let page = Page(rawValue: selectedPage) else { return }
        
        switch page {
        case .users:
            pages[page.rawValue]?.dataSource = viewModel?.usersFiltered ?? []
        case .savedUsers:
            pages[page.rawValue]?.dataSource = viewModel?.savedUsersFiltered ?? []
        }
    }
    
    private func reloadUsersData(for page: Page) {
        switch page {
        case .users:
            pages[page.rawValue]?.dataSource = viewModel?.users ?? []
        case .savedUsers:
            pages[page.rawValue]?.dataSource = viewModel?.savedUsers ?? []
        }
    }
    
    // MARK: Actions
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        goToPage(with: sender.selectedSegmentIndex)
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        viewModel?.searchText = textField.text
    }
    
    @objc private func editingDidEnd(_ textField: UITextField) {
        viewModel?.searchText = textField.text
    }
}

// MARK: - Setup UI

extension UsersBaseViewController {
    
    private func setupUI() {
        setupSegmentedControl()
        setupSearchInput()
        setupPages()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        
        for page in Page.allCases {
            segmentedControl.insertSegment(withTitle: page.title, at: page.rawValue, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = Page.users.rawValue
    }
    
    private func setupSearchInput() {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: searchInput.frame.height, height: searchInput.frame.height))
        imageView.center = leftView.center
        leftView.addSubview(imageView)
        searchInput.leftView = leftView
        searchInput.leftViewMode = .always
        searchInput.placeholder = "Search"
        searchInput.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        searchInput.addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
        searchInput.addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEndOnExit)
    }
    
    private func setupPages() {
        for page in Page.allCases {
            let vc: UsersViewController? = storyboard?.instantiate()
            vc?.view.tag = page.rawValue
            vc?.delegate = self
            
            if page == .users {
                vc?.allowInfiniteScroll = true
            }
            
            pages.append(vc)
        }
        
        if let startVC = pages.first, let vc = startVC {
            pageViewController?.delegate = self
            pageViewController?.dataSource = self
            pageViewController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension UsersBaseViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = viewController.view.tag
        return index == 0 ? nil : pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = viewController.view.tag
        return index == pages.count - 1 ? nil : pages[index + 1]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        Page.allCases.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        Page.users.rawValue
    }
    
    func goToPage(with index: Int) {
        if let vc = pages[index] {
            pageViewController?.setViewControllers([vc],
                                                   direction: selectedPage > index ? .reverse : .forward,
                                                   animated: true,
                                                   completion: nil)
            selectedPage = index
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension UsersBaseViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            selectedPage = pageViewController.viewControllers?.first?.view.tag ?? 0
            segmentedControl.selectedSegmentIndex = selectedPage
        }
    }
}

// MARK: - UsersViewControllerDelegate

extension UsersBaseViewController: UsersViewControllerDelegate {
    
    func didSelectRow(at indexPath: IndexPath) {
        if let selectedType = Page(rawValue: selectedPage) {
            let backBarButtonItem = UIBarButtonItem(title: selectedType.title,
                                                    style: .plain,
                                                    target: nil,
                                                    action: nil)
            navigationItem.backBarButtonItem = backBarButtonItem
            
            switch selectedType {
            case .users:
                UserRouter.shared.openUserInfoPage(navigationController, delegate: self, data: viewModel?.users?[indexPath.row])
            case .savedUsers:
                UserRouter.shared.openUserInfoPage(navigationController, delegate: self, data: viewModel?.savedUsers?[indexPath.row])
            }
        }
    }
    
    func fetchNewDataRequested() {
        viewModel?.loadData()
    }
}

// MARK: - UserInfoViewControllerDelegate

extension UsersBaseViewController: UserInfoViewControllerDelegate {
    
    func localStorageUpdated() {
        viewModel?.loadDefaultData()
    }
}
