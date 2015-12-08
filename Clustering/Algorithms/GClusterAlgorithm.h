#import <Foundation/Foundation.h>
#import "GClusterItem.h"
#import "GQTPointQuadTree.h"

@interface GClusterAlgorithm: NSObject
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) GQTPointQuadTree *quadTree;
@property (nonatomic, readwrite, assign) CGFloat minZoom;
@property (nonatomic, readwrite, assign) CGFloat maxZoom;

- (void)addItem:(id <GClusterItem>) item inBounds:(GMSCoordinateBounds *)bounds;
- (void)addItems:(NSArray *)items inBounds:(GMSCoordinateBounds *)bounds;
- (void)removeItem:(id <GClusterItem>) item;
- (void)removeItems;
- (void)removeItemsFromMap:(GMSMapView*)mapView;
- (void)removeItemsNotInRectangle:(CGRect)rect;
- (void)hideItemsNotInBounds: (GMSCoordinateBounds *)bounds forZoom:(CGFloat)zoom;

- (void)removeItem:(id <GClusterItem>) item;
- (void)removeClusterItemsInSet:(NSSet *)set;
- (void)removeClusterItemsInSet:(NSSet *)set fromMap:(GMSMapView*)mapView;
- (BOOL)containsItem:(id <GClusterItem>) item;
- (NSSet*)getClusters:(float)zoom;
- (NSArray*)visibleItems;

@end
