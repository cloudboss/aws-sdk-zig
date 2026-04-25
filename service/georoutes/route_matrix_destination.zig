const RouteMatrixDestinationOptions = @import("route_matrix_destination_options.zig").RouteMatrixDestinationOptions;

/// The route destination.
pub const RouteMatrixDestination = struct {
    /// Destination related options. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    options: ?RouteMatrixDestinationOptions = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    pub const json_field_names = .{
        .options = "Options",
        .position = "Position",
    };
};
