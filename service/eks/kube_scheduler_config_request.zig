const NodeResourcesFitConfig = @import("node_resources_fit_config.zig").NodeResourcesFitConfig;

/// The configuration for the Kubernetes scheduler on an Amazon EKS cluster.
pub const KubeSchedulerConfigRequest = struct {
    /// The node resource fit scoring configuration for the scheduler.
    node_resources_fit: ?NodeResourcesFitConfig = null,

    pub const json_field_names = .{
        .node_resources_fit = "nodeResourcesFit",
    };
};
