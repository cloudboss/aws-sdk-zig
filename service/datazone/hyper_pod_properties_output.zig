const HyperPodOrchestrator = @import("hyper_pod_orchestrator.zig").HyperPodOrchestrator;

/// The hyper pod properties of a Amazon Web Services Glue properties patch.
pub const HyperPodPropertiesOutput = struct {
    /// The cluster ARN of the hyper pod properties.
    cluster_arn: ?[]const u8 = null,

    /// The cluster name the hyper pod properties.
    cluster_name: []const u8,

    /// The orchestrator of the hyper pod properties.
    orchestrator: ?HyperPodOrchestrator = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .cluster_name = "clusterName",
        .orchestrator = "orchestrator",
    };
};
