#import <Foundation/Foundation.h>
#import "GCluster.h"
#import "GQuadItem.h"

@interface GStaticCluster : NSObject <GCluster> 

- (id)init;

- (void)add:(GQuadItem*)item;
- (void)remove:(GQuadItem*)item;

-(void)update;
- (void)removeAllItems;
- (GMSCoordinateBounds*)bounds;
- (NSSet*)items;
- (NSInteger)count;

//@property (nonatomic, strong) GMSMarker *marker;

@end
