const NodeRepairConfigOverrides = @import("node_repair_config_overrides.zig").NodeRepairConfigOverrides;

/// The node auto repair configuration for the node group.
pub const NodeRepairConfig = struct {
    /// Specifies whether to enable node auto repair for the node group. Node auto
    /// repair is
    /// disabled by default.
    enabled: ?bool = null,

    /// Specify the maximum number of nodes that can be repaired concurrently or in
    /// parallel,
    /// expressed as a count of unhealthy nodes. This gives you finer-grained
    /// control over the
    /// pace of node replacements. When using this, you cannot also set
    /// `maxParallelNodesRepairedPercentage` at the same time.
    max_parallel_nodes_repaired_count: ?i32 = null,

    /// Specify the maximum number of nodes that can be repaired concurrently or in
    /// parallel,
    /// expressed as a percentage of unhealthy nodes. This gives you finer-grained
    /// control over the
    /// pace of node replacements. When using this, you cannot also set
    /// `maxParallelNodesRepairedCount` at the same time.
    max_parallel_nodes_repaired_percentage: ?i32 = null,

    /// Specify a count threshold of unhealthy nodes, above which node auto
    /// repair actions will stop. When using this, you cannot also set
    /// `maxUnhealthyNodeThresholdPercentage` at the same time.
    max_unhealthy_node_threshold_count: ?i32 = null,

    /// Specify a percentage threshold of unhealthy nodes, above which node auto
    /// repair actions will stop. When using this, you cannot also set
    /// `maxUnhealthyNodeThresholdCount` at the same time.
    max_unhealthy_node_threshold_percentage: ?i32 = null,

    /// Specify granular overrides for specific repair actions. These overrides
    /// control the
    /// repair action and the repair delay time before a node is considered eligible
    /// for repair.
    /// If you use this, you must specify all the values.
    node_repair_config_overrides: ?[]const NodeRepairConfigOverrides = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .max_parallel_nodes_repaired_count = "maxParallelNodesRepairedCount",
        .max_parallel_nodes_repaired_percentage = "maxParallelNodesRepairedPercentage",
        .max_unhealthy_node_threshold_count = "maxUnhealthyNodeThresholdCount",
        .max_unhealthy_node_threshold_percentage = "maxUnhealthyNodeThresholdPercentage",
        .node_repair_config_overrides = "nodeRepairConfigOverrides",
    };
};
