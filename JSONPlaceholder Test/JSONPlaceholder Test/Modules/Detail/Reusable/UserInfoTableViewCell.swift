//
//  UserInfoTableViewCell.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 29/08/22.
//

import UIKit
import SkeletonView
import MapKit

struct UserCellViewModel {
    let name: String
    let email: String
    let phone: String
    let website: String
    let coordinates: Coordinates
    
    init(name: String, email: String, phone: String, website: String, coordinates: Coordinates) {
        self.name = name
        self.email = email
        self.phone = phone
        self.website = website
        self.coordinates = coordinates
    }
}

class UserInfoTableViewCell: UITableViewCell {

    // MARK: - IBOutlets -
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneTitleLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteTitleLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var containerMapView: UIView!
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        map.mapType = .standard
        map.isScrollEnabled = false
        map.isZoomEnabled = false
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 8
        return map
    }()
    
    // MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        addSubviews()
        setUpConstraints()
        configureTapGestures()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        emailLabel.text = nil
        phoneLabel.text = nil
        websiteLabel.text = nil
    }
    
    // MARK: - Private methods -
    private func setupView() {
        selectionStyle = .none
        nameTitleLabel.text = "name: "
        nameTitleLabel.font = UIFont.systemFont(ofSize: 12)
        nameTitleLabel.textColor = .gray
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor(named: "letterColor")
        nameLabel.isSkeletonable = true
        nameLabel.skeletonCornerRadius = 4
        emailTitleLabel.text = "email: "
        emailTitleLabel.font = UIFont.systemFont(ofSize: 12)
        emailTitleLabel.textColor = .gray
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textColor = UIColor(named: "letterColor")
        emailLabel.isSkeletonable = true
        emailLabel.skeletonCornerRadius = 4
        phoneTitleLabel.text = "phone: "
        phoneTitleLabel.font = UIFont.systemFont(ofSize: 12)
        phoneTitleLabel.textColor = .gray
        phoneLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.textColor = .systemBlue
        phoneLabel.isSkeletonable = true
        phoneLabel.skeletonCornerRadius = 4
        websiteTitleLabel.text = "website: "
        websiteTitleLabel.font = UIFont.systemFont(ofSize: 12)
        websiteTitleLabel.textColor = .gray
        websiteLabel.font = UIFont.systemFont(ofSize: 16)
        websiteLabel.textColor = UIColor(named: "letterColor")
        websiteLabel.isSkeletonable = true
        websiteLabel.skeletonCornerRadius = 4
        containerMapView.isSkeletonable = true
        containerMapView.backgroundColor = .clear
        containerMapView.skeletonCornerRadius = 8
        mapView.center = containerMapView.center
    }
    
    private func addSubviews() {
        containerMapView.addSubview(mapView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: containerMapView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: containerMapView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: containerMapView.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: containerMapView.topAnchor)
        ])
    }
    
    private func configureTapGestures() {
        let phoneTapGesture = UITapGestureRecognizer(target: self, action: #selector(phoneCall))
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(phoneTapGesture)
    }
    
    @objc func phoneCall() {
        guard let phone = phoneLabel.text,
            !phone.isEmpty else {
            return
        }
        ActionManager.call(with: phone)
    }
    
    private func setMapRegion(with coordinates: Coordinates, for name: String) {
        let location =  CLLocationCoordinate2D(
            latitude: Double(coordinates.lat) ?? 0,
            longitude: Double(coordinates.lng) ?? 0
        )
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        )
        let annontation = MKPointAnnotation()
        annontation.coordinate = location
        annontation.title = name
        mapView.addAnnotation(annontation)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func callNumber(phoneNumber:String) {
        let cleanPhone = phoneNumber.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(cleanPhone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL as URL)
            }
        }
    }
    
    // MARK: - Public methods -
    func configure(with model: UserCellViewModel?) {
        guard let model = model else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.nameLabel.showAnimatedGradientSkeleton()
                strongSelf.emailLabel.showAnimatedGradientSkeleton()
                strongSelf.phoneLabel.showAnimatedGradientSkeleton()
                strongSelf.websiteLabel.showAnimatedGradientSkeleton()
                strongSelf.containerMapView.showAnimatedGradientSkeleton()
                strongSelf.isUserInteractionEnabled = false
            }
            return
        }
        nameLabel.hideSkeleton()
        emailLabel.hideSkeleton()
        phoneLabel.hideSkeleton()
        websiteLabel.hideSkeleton()
        containerMapView.hideSkeleton()
        nameLabel.stopSkeletonAnimation()
        emailLabel.stopSkeletonAnimation()
        phoneLabel.stopSkeletonAnimation()
        websiteLabel.stopSkeletonAnimation()
        containerMapView.stopSkeletonAnimation()
        isUserInteractionEnabled = true
        nameLabel.text = model.name
        emailLabel.text = model.email
        phoneLabel.text = model.phone
        websiteLabel.text = model.website
        setMapRegion(with: model.coordinates, for: model.name)
        callNumber(phoneNumber: model.phone)
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension UserInfoTableViewCell {
    static let reuseIdentifier = "UserInfoTableViewCell"
}
