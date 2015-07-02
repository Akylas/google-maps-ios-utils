#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GMSMarker.h>

@class  GQuadItem;
@protocol GClusterItem <NSObject>

@property (nonatomic, assign, readonly) CLLocationCoordinate2D position;

@property (nonatomic, readonly) GMSMarker *marker;

@end
