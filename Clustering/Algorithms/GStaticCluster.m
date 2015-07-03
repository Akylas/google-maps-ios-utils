#import "GStaticCluster.h"

@implementation GStaticCluster {
    CLLocationCoordinate2D _position;
    NSMutableSet *_items;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    if (self = [super init]) {
        _position = coordinate;
        _items = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)add:(GQuadItem*)item {
    [_items addObject:item];
}

-(GMSMarker*)marker
{
    return nil;
}

- (void)remove:(GQuadItem*)item {
    [_items removeObject:item];
}
- (NSSet*)items {
    return _items;
}

- (void)removeAllItems {
    [_items removeAllObjects];
}
- (CLLocationCoordinate2D)position {
    return _position;
}


-(void)updateCenter {
    float maxLat = -200;
    float maxLong = -200;
    float minLat = MAXFLOAT;
    float minLong = MAXFLOAT;
    for (GQuadItem* item in _items) {
        CLLocationCoordinate2D location = item.position;
        if (location.latitude < minLat) {
            minLat = location.latitude;
        }
        
        if (location.longitude < minLong) {
            minLong = location.longitude;
        }
        
        if (location.latitude > maxLat) {
            maxLat = location.latitude;
        }
        
        if (location.longitude > maxLong) {
            maxLong = location.longitude;
        }
    }
    
    _position = CLLocationCoordinate2DMake((maxLat + minLat) * 0.5, (maxLong + minLong) * 0.5);
}

@end
