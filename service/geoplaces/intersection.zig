const AccessPoint = @import("access_point.zig").AccessPoint;
const Address = @import("address.zig").Address;

/// All Intersections that are near the provided address.
pub const Intersection = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint,

    address: ?Address,

    /// The distance in meters from the QueryPosition.
    distance: ?i64,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set of four coordinates: `[{westward
    /// lng}, {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64,

    /// The `PlaceId` of the place result.
    place_id: []const u8,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64,

    /// The distance from the routing position of the nearby address to the street
    /// result.
    route_distance: ?i64,

    /// The localized display name of this result item based on request parameter
    /// `language`.
    title: []const u8,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .address = "Address",
        .distance = "Distance",
        .map_view = "MapView",
        .place_id = "PlaceId",
        .position = "Position",
        .route_distance = "RouteDistance",
        .title = "Title",
    };
};
