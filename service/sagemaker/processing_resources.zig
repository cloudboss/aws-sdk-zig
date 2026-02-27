const ProcessingClusterConfig = @import("processing_cluster_config.zig").ProcessingClusterConfig;

/// Identifies the resources, ML compute instances, and ML storage volumes to
/// deploy for a processing job. In distributed training, you specify more than
/// one instance.
pub const ProcessingResources = struct {
    /// The configuration for the resources in a cluster used to run the processing
    /// job.
    cluster_config: ProcessingClusterConfig,

    pub const json_field_names = .{
        .cluster_config = "ClusterConfig",
    };
};
