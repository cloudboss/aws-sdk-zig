const RouteRentalPlace = @import("route_rental_place.zig").RouteRentalPlace;

/// Details corresponding to the departure for the leg.
pub const RouteRentalDeparture = struct {
    /// Place details corresponding to the departure.
    place: RouteRentalPlace,

    /// The departure time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
