const RouteFerryPlace = @import("route_ferry_place.zig").RouteFerryPlace;

/// Details corresponding to the departure for the leg.
pub const RouteFerryDeparture = struct {
    /// Place details corresponding to the departure.
    place: RouteFerryPlace,

    /// The departure time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
