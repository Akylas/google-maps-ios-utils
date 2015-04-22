//
//  ClusterMapViewController.m
//  Google Maps iOS Example
//
//  Created by Colin Edwards on 2/1/14.
//
//

#import "ClusterMapViewController.h"

#import "Spot.h"
#import "NonHierarchicalDistanceBasedAlgorithm.h"
#import "GDefaultClusterRenderer.h"

@implementation ClusterMapViewController {
    GMSMapView *mapView_;
    GClusterManager *clusterManager_;
    NSMutableArray *spots;
    NSMutableArray *markers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:51.503186
                                                            longitude:-0.126446
                                                                 zoom:9.5];
	
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;
    self.view = mapView_;
    spots = [NSMutableArray array];
    markers = [NSMutableArray array];
    
    clusterManager_ = [GClusterManager managerWithMapView:mapView_
                                               algorithm:[[NonHierarchicalDistanceBasedAlgorithm alloc] init]
                                                renderer:[[GDefaultClusterRenderer alloc] initWithMapView:mapView_]];

    [mapView_ setDelegate:clusterManager_];
    
    for (int i=0; i<12000; i++) {
        Spot* spot = [self generateSpot]; //auto add to markers
        [spots addObject:spot];
        [clusterManager_ addItem:spot];
    }

    [clusterManager_ cluster];
    [clusterManager_ setDelegate:self];
}






- (void)mapView:(GMSMapView *)mapView_ didChangeCameraPosition:(GMSCameraPosition *)position {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(updateMapResults) object:nil];
    [self performSelector:@selector(updateMapResults) withObject:nil afterDelay:0.3];
}
//
- (void)updateMapResults {
    [self addOrRemovePinsNotOnScreen];
}

- (void)addOrRemovePinsNotOnScreen {
    [clusterManager_ hideItemsNotInVisibleBounds];
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [[[UIAlertView alloc] initWithTitle:@"DidTapMarker" message:marker.title delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Spot*)generateSpot {
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.title = [NSString stringWithFormat:@"Test %f", [self getRandomNumberBetween:1 maxNumber:100]];
    marker.position = CLLocationCoordinate2DMake(
                                                 [self getRandomNumberBetween:51.38494009999999 maxNumber:51.6723432],
                                                 [self getRandomNumberBetween:-0.3514683 maxNumber:0.148271]);
    
    Spot* spot = [[Spot alloc] init];
    spot.location = marker.position;
    spot.marker = marker;
    [markers addObject:marker];
    return spot;
}

- (double)getRandomNumberBetween:(double)min maxNumber:(double)max
{
    return min + (max - min)*drand48();
}

@end
