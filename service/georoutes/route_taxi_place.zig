const RouteAccessPointDetails = @import("route_access_point_details.zig").RouteAccessPointDetails;
const RouteStationDetails = @import("route_station_details.zig").RouteStationDetails;
const RouteTaxiPlaceType = @import("route_taxi_place_type.zig").RouteTaxiPlaceType;

/// Place details corresponding to the arrival or departure.
pub const RouteTaxiPlace = struct {
    /// Details of the access point.
    access_point_details: ?RouteAccessPointDetails = null,

    /// The name of the place.
    name: ?[]const u8 = null,

    /// Position provided in the request.
    original_position: ?[]const f64 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Details about the station.
    station_details: ?RouteStationDetails = null,

    /// The type of the place.
    type: ?RouteTaxiPlaceType = null,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32 = null,

    pub const json_field_names = .{
        .access_point_details = "AccessPointDetails",
        .name = "Name",
        .original_position = "OriginalPosition",
        .position = "Position",
        .station_details = "StationDetails",
        .type = "Type",
        .waypoint_index = "WaypointIndex",
    };
};
