const RouteVehiclePlace = @import("route_vehicle_place.zig").RouteVehiclePlace;

/// Details corresponding to the arrival for a leg.
pub const RouteVehicleArrival = struct {
    /// Place details corresponding to the arrival.
    place: RouteVehiclePlace,

    /// The arrival time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
