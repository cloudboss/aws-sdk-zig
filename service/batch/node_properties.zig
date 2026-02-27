const NodeRangeProperty = @import("node_range_property.zig").NodeRangeProperty;

/// An object that represents the node properties of a multi-node parallel job.
///
/// Node properties can't be specified for Amazon EKS based job definitions.
pub const NodeProperties = struct {
    /// Specifies the node index for the main node of a multi-node parallel job.
    /// This node index
    /// value must be fewer than the number of nodes.
    main_node: i32,

    /// A list of node ranges and their properties that are associated with a
    /// multi-node parallel
    /// job.
    node_range_properties: []const NodeRangeProperty,

    /// The number of nodes that are associated with a multi-node parallel job.
    num_nodes: i32,

    pub const json_field_names = .{
        .main_node = "mainNode",
        .node_range_properties = "nodeRangeProperties",
        .num_nodes = "numNodes",
    };
};
