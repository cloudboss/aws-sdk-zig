const RouteStationDetails = @import("route_station_details.zig").RouteStationDetails;
const RouteTransitPlaceType = @import("route_transit_place_type.zig").RouteTransitPlaceType;

/// Place details corresponding to the arrival or departure.
pub const RouteTransitPlace = struct {
    /// The name of the place.
    name: ?[]const u8 = null,

    /// Position provided in the request.
    original_position: ?[]const f64 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Details about the station.
    station_details: ?RouteStationDetails = null,

    /// The type of the place.
    @"type": ?RouteTransitPlaceType = null,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .original_position = "OriginalPosition",
        .position = "Position",
        .station_details = "StationDetails",
        .@"type" = "Type",
        .waypoint_index = "WaypointIndex",
    };
};
