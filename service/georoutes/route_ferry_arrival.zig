const RouteFerryPlace = @import("route_ferry_place.zig").RouteFerryPlace;

/// Details corresponding to the arrival for the leg.
pub const RouteFerryArrival = struct {
    /// Place details corresponding to the arrival.
    place: RouteFerryPlace,

    /// The arrival time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
