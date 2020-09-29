//
//  FlightsVC.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
import MapKit

class FlightsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: VPFlightsProtocol?
    var airplaneImages: [String:UIImage] = [:]
    var filteredCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
        setInitialMapRegion()
    }
    
    private func configureHeaderView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1),#colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 0)].map{$0.cgColor}
        gradientLayer.locations = [0.3, 1.0]
        headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setInitialMapRegion() {
        let istanbulCoordinates = (latitude: 41.015137, longitude: 28.979530)
        let meters: CLLocationDistance = 100000
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: istanbulCoordinates.latitude,
            longitude: istanbulCoordinates.longitude),
                                        latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        presenter?.onFilterTap()
    }
}

extension FlightsVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let bounds = mapView.region.boundingBoxCoordinates
        let latMin = bounds[3].latitude
        let longMin = bounds[3].longitude
        let latMax = bounds[1].latitude
        let longMax = bounds[1].longitude
        presenter?.onMapRegionChange(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "airplane")
        annotationView.canShowCallout = true
        let title = annotation.title ?? ""
        let image = airplaneImages[title ?? ""]
        annotationView.image = image
        return annotationView
    }
}

extension FlightsVC: PVFlightsProtocol {
    
    func showFlights(_ flights: [FlightDM], filteredCountry: String?) {
        self.countryLabel.text = filteredCountry ?? "No Filter"
        self.mapView.removeAnnotations(self.mapView.annotations)
        flights.forEach { (flight) in
            let airplane = MKPointAnnotation()
            airplane.title = flight.callSign ?? "-"
            airplane.subtitle = flight.countryOrigin
            if let latitude = flight.latitude, let longitude = flight.longitude {
                airplane.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                self.mapView.addAnnotation(airplane)
                let rotationInRadian: Float = (flight.trueTrack ?? 0) / 180.0 * .pi
                let image = UIImage(named: "airplane")
                let rotatedImage = image?.rotate(radians: rotationInRadian)
                self.airplaneImages[flight.callSign ?? ""] = rotatedImage
            }
        }
    }
    
    func setLoading(isVisible: Bool) {
        if isVisible {
            loadingActivityIndicator.startAnimating()
        } else {
            loadingActivityIndicator.stopAnimating()
        }
    }
}
