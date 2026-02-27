const RoutePedestrianPlace = @import("route_pedestrian_place.zig").RoutePedestrianPlace;

/// Details corresponding to the departure for a leg.
///
/// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
///
/// Examples:
///
/// `2020-04-22T17:57:24Z`
///
/// `2020-04-22T17:57:24+02:00`
pub const RoutePedestrianDeparture = struct {
    /// The place details.
    place: RoutePedestrianPlace,

    /// The time.
    time: ?[]const u8,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
