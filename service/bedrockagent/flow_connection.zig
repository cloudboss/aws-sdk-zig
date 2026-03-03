const FlowConnectionConfiguration = @import("flow_connection_configuration.zig").FlowConnectionConfiguration;
const FlowConnectionType = @import("flow_connection_type.zig").FlowConnectionType;

/// Contains information about a connection between two nodes in the flow.
pub const FlowConnection = struct {
    /// The configuration of the connection.
    configuration: ?FlowConnectionConfiguration = null,

    /// A name for the connection that you can reference.
    name: []const u8,

    /// The node that the connection starts at.
    source: []const u8,

    /// The node that the connection ends at.
    target: []const u8,

    /// Whether the source node that the connection begins from is a condition node
    /// (`Conditional`) or not (`Data`).
    @"type": FlowConnectionType,

    pub const json_field_names = .{
        .configuration = "configuration",
        .name = "name",
        .source = "source",
        .target = "target",
        .@"type" = "type",
    };
};
