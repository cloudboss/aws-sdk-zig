const TrafficUsage = @import("traffic_usage.zig").TrafficUsage;

/// Options related to traffic.
pub const WaypointOptimizationTrafficOptions = struct {
    /// Determines if traffic should be used or ignored while calculating the route.
    ///
    /// Default value: `UseTrafficData`
    usage: ?TrafficUsage = null,

    pub const json_field_names = .{
        .usage = "Usage",
    };
};
