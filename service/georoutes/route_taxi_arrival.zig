const RouteTaxiPlace = @import("route_taxi_place.zig").RouteTaxiPlace;

/// Details corresponding to the arrival for the leg.
pub const RouteTaxiArrival = struct {
    /// Place details corresponding to the arrival.
    place: RouteTaxiPlace,

    /// The arrival time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
