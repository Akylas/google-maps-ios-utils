#import <Foundation/Foundation.h>
#import "GClusterAlgorithm.h"
#import "GQTPointQuadTree.h"

@interface NonHierarchicalDistanceBasedAlgorithm : NSObject<GClusterAlgorithm> 

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, readwrite, assign) NSInteger maxDistanceAtZoom;

- (void)removeItem:(id <GClusterItem>) item;
- (id)initWithMaxDistanceAtZoom:(NSInteger)maxDistanceAtZoom;

@end
