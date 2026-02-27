const UplinkConnectionDetails = @import("uplink_connection_details.zig").UplinkConnectionDetails;

/// Dataflow details for an uplink endpoint
pub const UplinkDataflowDetails = union(enum) {
    /// Uplink connection details for customer to Agent and Agent to Ground Station
    agent_connection_details: ?UplinkConnectionDetails,

    pub const json_field_names = .{
        .agent_connection_details = "agentConnectionDetails",
    };
};
