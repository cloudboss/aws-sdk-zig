const RouteVehiclePlace = @import("route_vehicle_place.zig").RouteVehiclePlace;

/// Details corresponding to the departure for the leg.
pub const RouteVehicleDeparture = struct {
    /// Place details corresponding to the departure.
    place: RouteVehiclePlace,

    /// The departure time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
