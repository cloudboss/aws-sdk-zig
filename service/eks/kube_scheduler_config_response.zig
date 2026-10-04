const NodeResourcesFitConfig = @import("node_resources_fit_config.zig").NodeResourcesFitConfig;

/// The Kubernetes scheduler configuration for an Amazon EKS cluster.
pub const KubeSchedulerConfigResponse = struct {
    /// The node resource fit scoring configuration for the scheduler.
    node_resources_fit: ?NodeResourcesFitConfig = null,

    pub const json_field_names = .{
        .node_resources_fit = "nodeResourcesFit",
    };
};
