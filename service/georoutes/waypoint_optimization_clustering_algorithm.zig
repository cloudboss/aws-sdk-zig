pub const WaypointOptimizationClusteringAlgorithm = enum {
    driving_distance,
    topology_segment,

    pub const json_field_names = .{
        .driving_distance = "DRIVING_DISTANCE",
        .topology_segment = "TOPOLOGY_SEGMENT",
    };
};
