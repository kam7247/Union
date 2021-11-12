//
//  MapViewController.swift
//  Union
//
//  Created by Камилла Буланова on 07.11.2021.
//

import UIKit
import MapboxMaps
import FittedSheets
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: Properties
    private var mapView: MapView!
    private var servicesBottomSheet: SheetViewController!
    private var serviceDetailsBottomSheet: SheetViewController!
    
    private let services = LocalDataBase.services
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupUserLocation()
        setupServicesBottomSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Setup
    private func setupMapView() {
        let myResourceOptions = ResourceOptions(accessToken: Constants.API_KEY)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,
                                              styleURI: StyleURI.dark)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        let manager = mapView.annotations.makePointAnnotationManager()
        manager.delegate = self
        services.forEach { service in
            let location = service.location
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: location[0],
                                                                                     longitude: location[1]))
            pointAnnotation.userInfo = [ "id" : service.id]
            pointAnnotation.image = .init(image: UIImage(named: "redPin")!, name: "redPin")
            manager.annotations.append(pointAnnotation)
        }
        manager.delegate = self
        mapView.ornaments.options.scaleBar.visibility = .hidden
        mapView.ornaments.options.compass.visibility = .hidden
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
    }
    
    private func setupUserLocation() {
        mapView.location.options.puckType = .puck2D()
        mapView.mapboxMap.onNext(.mapLoaded) { [weak self] _ in
            guard let self = self else { return }
            if let location = self.mapView.location.latestLocation {
                self.mapView.camera.ease(
                    to: CameraOptions(
                        center: location.coordinate,
                        zoom: 15
                    ),
                    duration: 0)
            }
        }
    }
    
    private func setupServicesBottomSheet() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.delegate = self
        
        let options = SheetOptions(
            presentingViewCornerRadius: 15,
            useInlineMode: true
        )
        servicesBottomSheet = SheetViewController(
            controller: bottomSheetVC,
            sizes: [
                .fixed(100),
                .fixed(200),
                .fixed(300),
                .fixed(500),
                .fixed(700),
                .fullscreen
            ],
            options: options
        )
        servicesBottomSheet.dismissOnPull = false
        servicesBottomSheet.allowPullingPastMaxHeight = false
        servicesBottomSheet.allowGestureThroughOverlay = true
        servicesBottomSheet.animateIn(to: view, in: self)
    }
    
    private func setupDetailsServiceBottomSheet(with service: ServiceModel) {
        let bottomSheetVC = ServiceDetailsViewController()
        bottomSheetVC.selectedService = service
        
        let options = SheetOptions(
            useInlineMode: true
        )
        serviceDetailsBottomSheet = SheetViewController(
            controller: bottomSheetVC,
            sizes: [.fullscreen],
            options: options
        )
        serviceDetailsBottomSheet.dismissOnPull = true
        serviceDetailsBottomSheet.allowPullingPastMaxHeight = false
        serviceDetailsBottomSheet.animateIn(to: view, in: self)
    }
}

extension MapViewController: PresenterDelegate {
    func presentDetaulViewController(with service: ServiceModel) {
        setupDetailsServiceBottomSheet(with: service)
    }
}

extension MapViewController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        guard let annotation = annotations.first, let id = annotation.userInfo?["id"] as? Int else { return }
        guard let service = services.first(where: { $0.id == id }) else { return }
        presentDetaulViewController(with: service)
    }
}
