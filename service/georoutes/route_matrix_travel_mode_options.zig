const RouteMatrixCarOptions = @import("route_matrix_car_options.zig").RouteMatrixCarOptions;
const RouteMatrixScooterOptions = @import("route_matrix_scooter_options.zig").RouteMatrixScooterOptions;
const RouteMatrixTruckOptions = @import("route_matrix_truck_options.zig").RouteMatrixTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const RouteMatrixTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is "Car"
    car: ?RouteMatrixCarOptions = null,

    /// Travel mode options when the provided travel mode is `Scooter`
    ///
    /// When travel mode is set to `Scooter`, then the avoidance option
    /// `ControlledAccessHighways` defaults to `true`.
    scooter: ?RouteMatrixScooterOptions = null,

    /// Travel mode options when the provided travel mode is "Truck"
    truck: ?RouteMatrixTruckOptions = null,

    pub const json_field_names = .{
        .car = "Car",
        .scooter = "Scooter",
        .truck = "Truck",
    };
};
