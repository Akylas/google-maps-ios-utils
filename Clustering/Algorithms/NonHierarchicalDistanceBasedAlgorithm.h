#import <Foundation/Foundation.h>
#import "GClusterAlgorithm.h"
#import "GQTPointQuadTree.h"

@interface NonHierarchicalDistanceBasedAlgorithm : NSObject<GClusterAlgorithm> 

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, readwrite, assign) NSInteger maxDistanceAtZoom;

- (id)initWithMaxDistanceAtZoom:(NSInteger)maxDistanceAtZoom;

@end
