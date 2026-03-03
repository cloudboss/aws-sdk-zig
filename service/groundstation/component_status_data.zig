const AgentStatus = @import("agent_status.zig").AgentStatus;

/// Data on the status of agent components.
pub const ComponentStatusData = struct {
    /// Bytes received by the component.
    bytes_received: ?i64 = null,

    /// Bytes sent by the component.
    bytes_sent: ?i64 = null,

    /// Capability ARN of the component.
    capability_arn: []const u8,

    /// The Component type.
    component_type: []const u8,

    /// Dataflow UUID associated with the component.
    dataflow_id: []const u8,

    /// Packets dropped by component.
    packets_dropped: ?i64 = null,

    /// Component status.
    status: AgentStatus,

    pub const json_field_names = .{
        .bytes_received = "bytesReceived",
        .bytes_sent = "bytesSent",
        .capability_arn = "capabilityArn",
        .component_type = "componentType",
        .dataflow_id = "dataflowId",
        .packets_dropped = "packetsDropped",
        .status = "status",
    };
};
