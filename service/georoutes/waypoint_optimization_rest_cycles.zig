const WaypointOptimizationRestCycleDurations = @import("waypoint_optimization_rest_cycle_durations.zig").WaypointOptimizationRestCycleDurations;

/// Resting phase of the cycle.
pub const WaypointOptimizationRestCycles = struct {
    /// Long cycle for a driver work-rest schedule.
    long_cycle: WaypointOptimizationRestCycleDurations,

    /// Short cycle for a driver work-rest schedule
    short_cycle: WaypointOptimizationRestCycleDurations,

    pub const json_field_names = .{
        .long_cycle = "LongCycle",
        .short_cycle = "ShortCycle",
    };
};
