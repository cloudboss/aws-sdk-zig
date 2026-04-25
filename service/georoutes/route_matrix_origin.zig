const RouteMatrixOriginOptions = @import("route_matrix_origin_options.zig").RouteMatrixOriginOptions;

/// The start position for the route in World Geodetic System (WGS 84) format:
/// [longitude, latitude].
pub const RouteMatrixOrigin = struct {
    /// Origin related options. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    options: ?RouteMatrixOriginOptions = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    pub const json_field_names = .{
        .options = "Options",
        .position = "Position",
    };
};
