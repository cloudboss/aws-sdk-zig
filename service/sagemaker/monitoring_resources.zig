const MonitoringClusterConfig = @import("monitoring_cluster_config.zig").MonitoringClusterConfig;

/// Identifies the resources to deploy for a monitoring job.
pub const MonitoringResources = struct {
    /// The configuration for the cluster resources used to run the processing job.
    cluster_config: MonitoringClusterConfig,

    pub const json_field_names = .{
        .cluster_config = "ClusterConfig",
    };
};
