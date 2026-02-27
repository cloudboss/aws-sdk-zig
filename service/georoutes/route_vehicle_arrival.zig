const RouteVehiclePlace = @import("route_vehicle_place.zig").RouteVehiclePlace;

/// Details corresponding to the arrival for a leg.
pub const RouteVehicleArrival = struct {
    /// The place details.
    place: RouteVehiclePlace,

    /// The time.
    time: ?[]const u8,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
