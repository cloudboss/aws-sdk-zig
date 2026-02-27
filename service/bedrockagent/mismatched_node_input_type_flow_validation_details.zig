const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Details about mismatched input data types in a node.
pub const MismatchedNodeInputTypeFlowValidationDetails = struct {
    /// The expected data type for the node input.
    expected_type: FlowNodeIODataType,

    /// The name of the input with the mismatched data type.
    input: []const u8,

    /// The name of the node containing the input with the mismatched data type.
    node: []const u8,

    pub const json_field_names = .{
        .expected_type = "expectedType",
        .input = "input",
        .node = "node",
    };
};
