const WaypointOptimizationAvoidanceAreaGeometry = @import("waypoint_optimization_avoidance_area_geometry.zig").WaypointOptimizationAvoidanceAreaGeometry;

/// The area to be avoided.
pub const WaypointOptimizationAvoidanceArea = struct {
    /// Geometry of the area to be avoided.
    geometry: WaypointOptimizationAvoidanceAreaGeometry,

    pub const json_field_names = .{
        .geometry = "Geometry",
    };
};
