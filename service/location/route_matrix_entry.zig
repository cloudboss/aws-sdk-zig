const RouteMatrixEntryError = @import("route_matrix_entry_error.zig").RouteMatrixEntryError;

/// The result for the calculated route of one `DeparturePosition`
/// `DestinationPosition` pair.
pub const RouteMatrixEntry = struct {
    /// The total distance of travel for the route.
    distance: ?f64 = null,

    /// The expected duration of travel for the route.
    duration_seconds: ?f64 = null,

    /// An error corresponding to the calculation of a route between the
    /// `DeparturePosition` and `DestinationPosition`.
    @"error": ?RouteMatrixEntryError = null,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration_seconds = "DurationSeconds",
        .@"error" = "Error",
    };
};
