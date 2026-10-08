const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Contains configurations for an output from a node.
pub const FlowNodeOutput = struct {
    /// A name for the output that you can reference.
    name: []const u8,

    /// The data type of the output. If the output doesn't match this type at
    /// runtime, a validation error will be thrown.
    type: FlowNodeIODataType,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
