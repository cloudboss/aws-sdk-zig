const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteNumber = @import("route_number.zig").RouteNumber;
const RouteRoadType = @import("route_road_type.zig").RouteRoadType;

/// The road on the route.
pub const RouteRoad = struct {
    /// Name of the road (localized).
    road_name: []const LocalizedString,

    /// Route number of the road.
    route_number: []const RouteNumber,

    /// Names of destinations that can be reached when traveling on the road.
    towards: []const LocalizedString,

    /// The type of road.
    type: ?RouteRoadType,

    pub const json_field_names = .{
        .road_name = "RoadName",
        .route_number = "RouteNumber",
        .towards = "Towards",
        .type = "Type",
    };
};
