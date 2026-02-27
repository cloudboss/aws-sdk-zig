const WaypointOptimizationAccessHoursEntry = @import("waypoint_optimization_access_hours_entry.zig").WaypointOptimizationAccessHoursEntry;

/// Access hours corresponding to when a destination can be visited.
pub const WaypointOptimizationAccessHours = struct {
    /// Contains the ID of the starting waypoint in this connection.
    from: WaypointOptimizationAccessHoursEntry,

    /// Contains the ID of the ending waypoint in this connection.
    to: WaypointOptimizationAccessHoursEntry,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
