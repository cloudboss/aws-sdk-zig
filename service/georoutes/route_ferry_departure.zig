const RouteFerryPlace = @import("route_ferry_place.zig").RouteFerryPlace;

/// Details corresponding to the departure for the leg.
pub const RouteFerryDeparture = struct {
    /// The place details.
    place: RouteFerryPlace,

    /// The time.
    time: ?[]const u8,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
