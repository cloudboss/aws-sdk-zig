const RouteFerryPlace = @import("route_ferry_place.zig").RouteFerryPlace;

/// Details corresponding to the arrival for the leg.
pub const RouteFerryArrival = struct {
    /// The place details.
    place: RouteFerryPlace,

    /// The time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
