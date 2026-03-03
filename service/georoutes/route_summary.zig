const RouteTollSummary = @import("route_toll_summary.zig").RouteTollSummary;

/// Summarized details for the leg including travel steps only. The Distance for
/// the travel only portion of the journey is the same as the Distance within
/// the Overview summary.
pub const RouteSummary = struct {
    /// Distance of the route.
    distance: i64 = 0,

    /// Duration of the route.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Toll summary for the complete route.
    tolls: ?RouteTollSummary = null,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
        .tolls = "Tolls",
    };
};
