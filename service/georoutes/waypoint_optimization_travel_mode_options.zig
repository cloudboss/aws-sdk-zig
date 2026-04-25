const WaypointOptimizationPedestrianOptions = @import("waypoint_optimization_pedestrian_options.zig").WaypointOptimizationPedestrianOptions;
const WaypointOptimizationTruckOptions = @import("waypoint_optimization_truck_options.zig").WaypointOptimizationTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const WaypointOptimizationTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is `Pedestrian`.
    pedestrian: ?WaypointOptimizationPedestrianOptions = null,

    /// Travel mode options when the provided travel mode is `Truck`.
    truck: ?WaypointOptimizationTruckOptions = null,

    pub const json_field_names = .{
        .pedestrian = "Pedestrian",
        .truck = "Truck",
    };
};
