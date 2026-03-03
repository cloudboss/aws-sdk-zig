const RouteMatrixDestinationOptions = @import("route_matrix_destination_options.zig").RouteMatrixDestinationOptions;

/// The route destination.
pub const RouteMatrixDestination = struct {
    /// Destination related options.
    options: ?RouteMatrixDestinationOptions = null,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    pub const json_field_names = .{
        .options = "Options",
        .position = "Position",
    };
};
