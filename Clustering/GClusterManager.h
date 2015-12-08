#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GClusterAlgorithm.h"
#import "GClusterRenderer.h"
#import "GQTPointQuadTreeItem.h"

@interface GMSMarker(CanCluster)
- (void)setCanBeClustered:(BOOL)value;
- (BOOL)canBeClustered;
@end

@interface GClusterManager : NSObject <GMSMapViewDelegate> 

@property(nonatomic, strong) GMSMapView *mapView;
@property(nonatomic, weak) id<GMSMapViewDelegate> delegate;
//@property(nonatomic, strong) id<GClusterAlgorithm> clusterAlgorithm;
@property(nonatomic, strong) id<GClusterRenderer> clusterRenderer;
@property(nonatomic, strong) NSMutableArray *items;

- (void)addItem:(id <GClusterItem>) item inAlgorithm:(GClusterAlgorithm*)algo;
- (void)addItems:(NSArray*) items inAlgorithm:(GClusterAlgorithm*)algo;
- (void)removeItems;
- (void)removeItemsNotInRectangle:(CGRect)rect;
- (void)hideItemsNotInVisibleBounds;

- (void)removeItem:(id <GClusterItem>) item fromAlgorithm:(GClusterAlgorithm*)algo;
-(BOOL)containsItem:(id<GClusterItem>)item inAlgorithm:(GClusterAlgorithm*)algo;
- (void)cluster;
-(void)clusterAlgo:(GClusterAlgorithm*)clusterAlgorithm;

- (void)addClusterAlgorithm:(GClusterAlgorithm*)clusterAlgorithm;
- (void)removeClusterAlgorithm:(GClusterAlgorithm*)clusterAlgorithm;

+ (instancetype)managerWithMapView:(GMSMapView*)googleMap
                          renderer:(id<GClusterRenderer>)renderer;

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)cameraPosition;
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)cameraPosition;
@end
