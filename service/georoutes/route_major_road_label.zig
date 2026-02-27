const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteNumber = @import("route_number.zig").RouteNumber;

/// Important labels including names and route numbers that differentiate the
/// current route from the alternatives presented.
pub const RouteMajorRoadLabel = struct {
    /// Name of the road (localized).
    road_name: ?LocalizedString,

    /// Route number of the road.
    route_number: ?RouteNumber,

    pub const json_field_names = .{
        .road_name = "RoadName",
        .route_number = "RouteNumber",
    };
};
