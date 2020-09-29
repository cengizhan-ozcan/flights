//
//  MKCoordinateRegionExtension.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/18/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import MapKit

extension MKCoordinateRegion {

    var boundingBoxCoordinates: [CLLocationCoordinate2D] {
        let halfLatDelta = self.span.latitudeDelta / 2
        let halfLngDelta = self.span.longitudeDelta / 2

        let topLeftCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let bottomRightCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )
        let bottomLeftCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let topRightCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )

        return [topLeftCoord, topRightCoord, bottomRightCoord, bottomLeftCoord]
    }

}
