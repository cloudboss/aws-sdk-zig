const WaypointOptimizationClusteringAlgorithm = @import("waypoint_optimization_clustering_algorithm.zig").WaypointOptimizationClusteringAlgorithm;
const WaypointOptimizationDrivingDistanceOptions = @import("waypoint_optimization_driving_distance_options.zig").WaypointOptimizationDrivingDistanceOptions;

/// Options for WaypointOptimizationClustering.
pub const WaypointOptimizationClusteringOptions = struct {
    /// The algorithm to be used. `DrivingDistance` assigns all the waypoints that
    /// are within driving distance of each other into a single cluster.
    /// `TopologySegment` assigns all the waypoints that are within the same
    /// topology segment into a single cluster. A Topology segment is a linear
    /// stretch of road between two junctions.
    algorithm: WaypointOptimizationClusteringAlgorithm,

    /// Driving distance options to be used when the clustering algorithm is
    /// DrivingDistance.
    driving_distance_options: ?WaypointOptimizationDrivingDistanceOptions,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .driving_distance_options = "DrivingDistanceOptions",
    };
};
