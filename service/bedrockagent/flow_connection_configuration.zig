const FlowConditionalConnectionConfiguration = @import("flow_conditional_connection_configuration.zig").FlowConditionalConnectionConfiguration;
const FlowDataConnectionConfiguration = @import("flow_data_connection_configuration.zig").FlowDataConnectionConfiguration;

/// The configuration of the connection.
pub const FlowConnectionConfiguration = union(enum) {
    /// The configuration of a connection originating from a Condition node.
    conditional: ?FlowConditionalConnectionConfiguration,
    /// The configuration of a connection originating from a node that isn't a
    /// Condition node.
    data: ?FlowDataConnectionConfiguration,

    pub const json_field_names = .{
        .conditional = "conditional",
        .data = "data",
    };
};
