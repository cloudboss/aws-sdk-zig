const WaypointOptimizationConstraint = @import("waypoint_optimization_constraint.zig").WaypointOptimizationConstraint;

/// The failed constraint.
pub const WaypointOptimizationFailedConstraint = struct {
    /// The failed constraint.
    constraint: ?WaypointOptimizationConstraint = null,

    /// Reason for the failed constraint.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .constraint = "Constraint",
        .reason = "Reason",
    };
};
