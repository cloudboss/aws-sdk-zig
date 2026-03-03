const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;

/// Configuration options for defining the setup of any node type within the
/// cluster.
pub const NodeConfig = struct {
    /// The number of nodes of a specific type within the cluster.
    count: ?i32 = null,

    /// A boolean value indicating whether a specific node type is active or
    /// inactive.
    enabled: ?bool = null,

    /// The instance type of a particular node within the cluster.
    @"type": ?OpenSearchPartitionInstanceType = null,

    pub const json_field_names = .{
        .count = "Count",
        .enabled = "Enabled",
        .@"type" = "Type",
    };
};
