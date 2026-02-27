/// Driving distance related options.
pub const WaypointOptimizationDrivingDistanceOptions = struct {
    /// DrivingDistance assigns all the waypoints that are within driving distance
    /// of each other into a single cluster.
    driving_distance: i64 = 0,

    pub const json_field_names = .{
        .driving_distance = "DrivingDistance",
    };
};
