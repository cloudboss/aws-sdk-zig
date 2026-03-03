/// Represents a parameter value that is applicable to a particular node
/// type.
pub const NodeTypeSpecificValue = struct {
    /// A node type to which the parameter value applies.
    node_type: ?[]const u8 = null,

    /// The parameter value for this node type.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .node_type = "NodeType",
        .value = "Value",
    };
};
