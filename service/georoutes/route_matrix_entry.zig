const RouteMatrixErrorCode = @import("route_matrix_error_code.zig").RouteMatrixErrorCode;

/// The calculated route matrix containing the results for all pairs of Origins
/// to Destination positions. Each row corresponds to one entry in Origins. Each
/// entry in the row corresponds to the route from that entry in Origins to an
/// entry in Destination positions.
pub const RouteMatrixEntry = struct {
    /// The total distance of travel for the route.
    distance: i64 = 0,

    /// The expected duration of travel for the route.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Error code that occurred during calculation of the route.
    @"error": ?RouteMatrixErrorCode = null,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
        .@"error" = "Error",
    };
};
