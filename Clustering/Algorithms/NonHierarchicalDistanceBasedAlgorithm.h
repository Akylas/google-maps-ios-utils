#import "GClusterAlgorithm.h"

@interface NonHierarchicalDistanceBasedAlgorithm : GClusterAlgorithm

@property (nonatomic, readwrite, assign) NSInteger maxDistanceAtZoom;

- (id)initWithMaxDistanceAtZoom:(NSInteger)maxDistanceAtZoom;

@end
