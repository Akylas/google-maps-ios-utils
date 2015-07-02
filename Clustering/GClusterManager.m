#import "GClusterManager.h"
#import "GCluster.h"

@implementation GClusterManager {
    CGFloat _zoom;
    NSMutableSet* _clusterAlgorithmSet;
}

- (void)setMapView:(GMSMapView*)mapView {
    _zoom = -1;
    _mapView = mapView;
}


- (void)addClusterAlgorithm:(id <GClusterAlgorithm>)algo {
    if (_clusterAlgorithmSet == nil) {
        _clusterAlgorithmSet = [NSMutableSet set];
    }
    [_clusterAlgorithmSet addObject:algo];
    [self clusterAlgo:algo];
}

- (void)removeClusterAlgorithm:(id <GClusterAlgorithm>)clusterAlgorithm {
    if (_clusterAlgorithmSet != nil) {
        [_clusterAlgorithmSet removeObject:clusterAlgorithm];
    }
}


- (void)setClusterRenderer:(id <GClusterRenderer>)clusterRenderer {
    _zoom = -1;
    _clusterRenderer = clusterRenderer;
}

- (void)addItem:(id <GClusterItem>) item inAlgorithm:(id <GClusterAlgorithm>)algo {
    [algo addItem:item];
}

- (void)removeItem:(id <GClusterItem>) item fromAlgorithm:(id <GClusterAlgorithm>)algo {
    [algo removeItem:item];
}

-(BOOL)containsItem:(id<GClusterItem>)item inAlgorithm:(id <GClusterAlgorithm>)algo{
    return [algo containsItem:item];
}

- (void)removeItems {
    [_clusterAlgorithmSet enumerateObjectsUsingBlock:^(id <GClusterAlgorithm> set, BOOL *stop) {
        [set removeItems];
    }];
    [_clusterRenderer clearCache];
}

- (void)removeItemsNotInRectangle:(CGRect)rect {
    [_clusterAlgorithmSet enumerateObjectsUsingBlock:^(id <GClusterAlgorithm> set, BOOL *stop) {
        [set removeItemsNotInRectangle:rect];
    }];
}

-(void)clusterAlgo:(id <GClusterAlgorithm>)clusterAlgorithm
{
    [_clusterRenderer clustersChanged:clusterAlgorithm forZoom:_zoom];
}

- (void)hideItemsNotInVisibleBounds{
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc]initWithRegion:self.mapView.projection.visibleRegion];
    [_clusterAlgorithmSet enumerateObjectsUsingBlock:^(id <GClusterAlgorithm> set, BOOL *stop) {
        [set hideItemsNotInBounds:bounds];
    }];
    [self cluster];
}

- (void)cluster {
    _zoom = floorf(self.mapView.camera.zoom);
    [_clusterAlgorithmSet enumerateObjectsUsingBlock:^(id <GClusterAlgorithm> set, BOOL *stop) {
        [self clusterAlgo:set];
    }];
}


#pragma mark mapview delegate

-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:willMove:)]) {
        [self.delegate mapView:mapView willMove:gesture];
    }
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)cameraPosition {
    

    CGFloat newZoom = floorf([cameraPosition zoom]);
    if (_zoom != newZoom) {
        _zoom = newZoom;
        [self hideItemsNotInVisibleBounds];
    } else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(hideItemsNotInVisibleBounds) object:nil];
        [self performSelector:@selector(hideItemsNotInVisibleBounds) withObject:nil afterDelay:0.3];
    }
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didChangeCameraPosition:)]) {
        [self.delegate mapView:mapView didChangeCameraPosition:cameraPosition];
    }
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)cameraPosition {
    assert(mapView == _mapView);
    
    // Don't re-compute clusters if the map has just been panned/tilted/rotated.
    CGFloat newZoom = floorf([cameraPosition zoom]);
    if (_zoom != newZoom) {
        _zoom = newZoom;
        
        [self cluster];
    }
    
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:idleAtCameraPosition:)]) {
        [self.delegate mapView:mapView idleAtCameraPosition:cameraPosition];
    }
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didTapAtCoordinate:)]) {
        [self.delegate mapView:mapView didTapAtCoordinate:coordinate];
    }
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didLongPressAtCoordinate:)]) {
        [self.delegate mapView:mapView didLongPressAtCoordinate:coordinate];
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didTapMarker:)]) {
        return [self.delegate mapView:mapView didTapMarker:marker];
    }
    
    return true;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didTapInfoWindowOfMarker:)]) {
        [self.delegate mapView:mapView didTapInfoWindowOfMarker:marker];
    }
}

- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didTapOverlay:)]) {
        [self.delegate mapView:mapView didTapOverlay:overlay];
    }
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:markerInfoWindow:)]) {
        return [self.delegate mapView:mapView markerInfoWindow:marker];
    }
    
    return nil;
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:markerInfoContents:)]) {
        return [self.delegate mapView:mapView markerInfoContents:marker];
    }
    
    return nil;
}

- (void)mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didBeginDraggingMarker:)]) {
        [self.delegate mapView:mapView didBeginDraggingMarker:marker];
    }
}

-(void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didEndDraggingMarker:)]) {
        [self.delegate mapView:mapView didEndDraggingMarker:marker];
    }
}

- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker {
    if ([self delegate] != nil
        && [self.delegate respondsToSelector:@selector(mapView:didDragMarker:)]) {
        [self.delegate mapView:mapView didDragMarker:marker];
    }
}

#pragma mark convenience

+ (instancetype)managerWithMapView:(GMSMapView*)googleMap
                          renderer:(id<GClusterRenderer>)renderer {
    GClusterManager *mgr = [[[self class] alloc] init];
    if(mgr) {
        mgr.mapView = googleMap;
        mgr.clusterRenderer = renderer;
    }
    return mgr;
}

@end
