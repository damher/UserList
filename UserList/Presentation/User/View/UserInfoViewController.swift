//
//  UserInfoViewController.swift
//  UserList
//
//  Created by Mher Davtyan on 28.07.22.
//

import UIKit
import MapKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func localStorageUpdated()
}

class UserInfoViewController: BaseViewController {

    // MARK: View
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    // MARK: Properties
    private var viewModel: UserInfoViewModelProtocol?
    
    weak var delegate: UserInfoViewControllerDelegate?
    var userData: UserViewModel?
    
    private var isUserSaved: Bool {
        viewModel?.user != nil
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: ViewModel
    private func setupViewModel() {
        viewModel = ServiceLocator.instance.resolve(UserInfoViewModelProtocol.self, argument: userData)
        
        viewModel?.userDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateButtons()
                self?.delegate?.localStorageUpdated()
            }
        }
        
        viewModel?.userDataRequested = { [weak self] in
            DispatchQueue.main.async {
                self?.updateButtons()
            }
        }
        
        viewModel?.fetchUser()
    }
        
    private func updateButtons() {
        saveButton.isHidden = false
        saveButton.isEnabled = !isUserSaved
        saveButton.applyGradient(colours: isUserSaved ? [UIColor.lightGray, UIColor.lightGray] : [UIColor.lightGreen, UIColor.darkGreen],
                                 locations: [0.2, 0.8])
        removeButton.isHidden = !isUserSaved
    }
    
    // MARK: Actions
    
    @IBAction func saveAction(_ sender: UIButton) {
        viewModel?.save()
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        viewModel?.remove()
    }
}

// MARK: - Setup UI

extension UserInfoViewController {
    
    private func setupUI() {
        setupUserData()
        setupButtons()
        setupMapView()
    }
    
    private func setupUserData() {
        title = userData?.name
        avatarView.setAvatar(by: userData?.mediumImage ?? "")
        nameLabel.text = userData?.name
        infoLabel.text = userData?.info
        countryLabel.text = userData?.country
        addressLabel.text = userData?.address
    }
    
    private func setupButtons() {
        saveButton.setTitle("Save user", for: .normal)
        saveButton.setTitle("User saved", for: .disabled)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .disabled)
        removeButton.setTitle("Remove user", for: .normal)
    }
    
    private func setupMapView() {
        if let location = userData?.location {
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: 200,
                                            longitudinalMeters: 200)
            
            mapView.setRegion(region, animated: false)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }
    }
}
