const RouteDirection = @import("route_direction.zig").RouteDirection;

/// The route number.
pub const RouteNumber = struct {
    /// Directional identifier of the route.
    direction: ?RouteDirection,

    /// List of languages for instructions corresponding to the route number.
    language: ?[]const u8,

    /// The route number.
    value: []const u8,

    pub const json_field_names = .{
        .direction = "Direction",
        .language = "Language",
        .value = "Value",
    };
};
