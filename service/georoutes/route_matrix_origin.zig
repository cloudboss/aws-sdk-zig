const RouteMatrixOriginOptions = @import("route_matrix_origin_options.zig").RouteMatrixOriginOptions;

/// The start position for the route.
pub const RouteMatrixOrigin = struct {
    /// Origin related options.
    options: ?RouteMatrixOriginOptions,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    pub const json_field_names = .{
        .options = "Options",
        .position = "Position",
    };
};
