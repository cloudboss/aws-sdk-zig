const RouteAccessPointDetails = @import("route_access_point_details.zig").RouteAccessPointDetails;
const RouteSideOfStreet = @import("route_side_of_street.zig").RouteSideOfStreet;
const RouteStationDetails = @import("route_station_details.zig").RouteStationDetails;
const RouteVehiclePlaceType = @import("route_vehicle_place_type.zig").RouteVehiclePlaceType;

/// Place details corresponding to the arrival or departure.
pub const RouteVehiclePlace = struct {
    /// Details of the access point.
    access_point_details: ?RouteAccessPointDetails = null,

    /// The name of the place.
    name: ?[]const u8 = null,

    /// Position provided in the request.
    original_position: ?[]const f64 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?RouteSideOfStreet = null,

    /// Details about the station.
    station_details: ?RouteStationDetails = null,

    /// The type of the place.
    @"type": ?RouteVehiclePlaceType = null,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32 = null,

    pub const json_field_names = .{
        .access_point_details = "AccessPointDetails",
        .name = "Name",
        .original_position = "OriginalPosition",
        .position = "Position",
        .side_of_street = "SideOfStreet",
        .station_details = "StationDetails",
        .@"type" = "Type",
        .waypoint_index = "WaypointIndex",
    };
};
