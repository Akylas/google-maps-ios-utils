#import <Foundation/Foundation.h>
#import "GCluster.h"
#import "GQuadItem.h"

@interface GStaticCluster : NSObject <GCluster> 

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)add:(GQuadItem*)item;
- (void)remove:(GQuadItem*)item;

-(void)updateCenter;
- (void)removeAllItems;

//@property (nonatomic, strong) GMSMarker *marker;

@end
