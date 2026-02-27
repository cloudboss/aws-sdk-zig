const DownlinkConnectionDetails = @import("downlink_connection_details.zig").DownlinkConnectionDetails;

/// Dataflow details for a downlink endpoint
pub const DownlinkDataflowDetails = union(enum) {
    /// Downlink connection details for customer to Agent and Agent to Ground
    /// Station
    agent_connection_details: ?DownlinkConnectionDetails,

    pub const json_field_names = .{
        .agent_connection_details = "agentConnectionDetails",
    };
};
