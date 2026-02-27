/// The compute node group configuration for a queue.
pub const ComputeNodeGroupConfiguration = struct {
    /// The compute node group ID for the compute node group configuration.
    compute_node_group_id: ?[]const u8,

    pub const json_field_names = .{
        .compute_node_group_id = "computeNodeGroupId",
    };
};
