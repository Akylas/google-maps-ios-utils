#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GClusterAlgorithm.h"
#import "GClusterRenderer.h"
#import "GQTPointQuadTreeItem.h"

@interface GClusterManager : NSObject <GMSMapViewDelegate> 

@property(nonatomic, strong) GMSMapView *mapView;
@property(nonatomic, weak) id<GMSMapViewDelegate> delegate;
//@property(nonatomic, strong) id<GClusterAlgorithm> clusterAlgorithm;
@property(nonatomic, strong) id<GClusterRenderer> clusterRenderer;
@property(nonatomic, strong) NSMutableArray *items;

- (void)addItem:(id <GClusterItem>) item inAlgorithm:(id <GClusterAlgorithm>)algo;
- (void)removeItems;
- (void)removeItemsNotInRectangle:(CGRect)rect;
- (void)hideItemsNotInVisibleBounds;

- (void)removeItem:(id <GClusterItem>) item;
- (BOOL)containsItem:(id <GClusterItem>) item;
- (void)cluster;
-(void)clusterAlgo:(id <GClusterAlgorithm>)clusterAlgorithm;

- (void)addClusterAlgorithm:(id <GClusterAlgorithm>)clusterAlgorithm;
- (void)removeClusterAlgorithm:(id <GClusterAlgorithm>)clusterAlgorithm;

+ (instancetype)managerWithMapView:(GMSMapView*)googleMap
                          renderer:(id<GClusterRenderer>)renderer;

@end
