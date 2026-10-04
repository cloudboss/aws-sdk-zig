const RouteTaxiPlace = @import("route_taxi_place.zig").RouteTaxiPlace;

/// Details corresponding to the departure for the leg.
pub const RouteTaxiDeparture = struct {
    /// Place details corresponding to the departure.
    place: RouteTaxiPlace,

    /// The departure time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
