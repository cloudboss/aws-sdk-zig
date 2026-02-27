const WaypointOptimizationConstraint = @import("waypoint_optimization_constraint.zig").WaypointOptimizationConstraint;

/// The failed constraint.
pub const WaypointOptimizationFailedConstraint = struct {
    /// The failed constraint.
    constraint: ?WaypointOptimizationConstraint,

    /// Reason for the failed constraint.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .constraint = "Constraint",
        .reason = "Reason",
    };
};
