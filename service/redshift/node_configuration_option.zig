const Mode = @import("mode.zig").Mode;

/// A list of node configurations.
pub const NodeConfigurationOption = struct {
    /// The estimated disk utilizaton percentage.
    estimated_disk_utilization_percent: ?f64,

    /// The category of the node configuration recommendation.
    mode: ?Mode,

    /// The node type, such as, "ra3.4xlarge".
    node_type: ?[]const u8,

    /// The number of nodes.
    number_of_nodes: ?i32,
};
