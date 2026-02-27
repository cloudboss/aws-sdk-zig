const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Details about mismatched output data types in a node.
pub const MismatchedNodeOutputTypeFlowValidationDetails = struct {
    /// The expected data type for the node output.
    expected_type: FlowNodeIODataType,

    /// The name of the node containing the output with the mismatched data type.
    node: []const u8,

    /// The name of the output with the mismatched data type.
    output: []const u8,

    pub const json_field_names = .{
        .expected_type = "expectedType",
        .node = "node",
        .output = "output",
    };
};
