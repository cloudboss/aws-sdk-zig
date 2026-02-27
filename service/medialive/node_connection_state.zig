/// Used in DescribeNodeSummary.
pub const NodeConnectionState = enum {
    connected,
    disconnected,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
    };
};
