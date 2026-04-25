const WaypointOptimizationFailedConstraint = @import("waypoint_optimization_failed_constraint.zig").WaypointOptimizationFailedConstraint;

/// The impeding waypoint.
pub const WaypointOptimizationImpedingWaypoint = struct {
    /// Failed constraints for an impeding waypoint.
    failed_constraints: []const WaypointOptimizationFailedConstraint,

    /// The waypoint Id.
    id: []const u8,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    pub const json_field_names = .{
        .failed_constraints = "FailedConstraints",
        .id = "Id",
        .position = "Position",
    };
};
