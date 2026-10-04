const RouteCarOptions = @import("route_car_options.zig").RouteCarOptions;
const RouteIntermodalOptions = @import("route_intermodal_options.zig").RouteIntermodalOptions;
const RoutePedestrianOptions = @import("route_pedestrian_options.zig").RoutePedestrianOptions;
const RouteScooterOptions = @import("route_scooter_options.zig").RouteScooterOptions;
const RouteTransitOptions = @import("route_transit_options.zig").RouteTransitOptions;
const RouteTruckOptions = @import("route_truck_options.zig").RouteTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const RouteTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is `Car`.
    car: ?RouteCarOptions = null,

    /// Travel mode options when the provided travel mode is `Intermodal`.
    ///
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    intermodal: ?RouteIntermodalOptions = null,

    /// Travel mode options when the provided travel mode is `Pedestrian`.
    pedestrian: ?RoutePedestrianOptions = null,

    /// Travel mode options when the provided travel mode is `Scooter`.
    ///
    /// When travel mode is set to `Scooter`, then the avoidance option
    /// `ControlledAccessHighways` defaults to `true`.
    scooter: ?RouteScooterOptions = null,

    /// Travel mode options when the provided travel mode is `Transit`.
    ///
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    transit: ?RouteTransitOptions = null,

    /// Travel mode options when the provided travel mode is `Truck`.
    truck: ?RouteTruckOptions = null,

    pub const json_field_names = .{
        .car = "Car",
        .intermodal = "Intermodal",
        .pedestrian = "Pedestrian",
        .scooter = "Scooter",
        .transit = "Transit",
        .truck = "Truck",
    };
};
