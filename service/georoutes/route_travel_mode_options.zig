const RouteCarOptions = @import("route_car_options.zig").RouteCarOptions;
const RoutePedestrianOptions = @import("route_pedestrian_options.zig").RoutePedestrianOptions;
const RouteScooterOptions = @import("route_scooter_options.zig").RouteScooterOptions;
const RouteTruckOptions = @import("route_truck_options.zig").RouteTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const RouteTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is "Car"
    car: ?RouteCarOptions = null,

    /// Travel mode options when the provided travel mode is "Pedestrian"
    pedestrian: ?RoutePedestrianOptions = null,

    /// Travel mode options when the provided travel mode is `Scooter`
    ///
    /// When travel mode is set to `Scooter`, then the avoidance option
    /// `ControlledAccessHighways` defaults to `true`.
    scooter: ?RouteScooterOptions = null,

    /// Travel mode options when the provided travel mode is "Truck"
    truck: ?RouteTruckOptions = null,

    pub const json_field_names = .{
        .car = "Car",
        .pedestrian = "Pedestrian",
        .scooter = "Scooter",
        .truck = "Truck",
    };
};
