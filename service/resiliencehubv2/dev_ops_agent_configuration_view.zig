const DevOpsAgentConnectionStatus = @import("dev_ops_agent_connection_status.zig").DevOpsAgentConnectionStatus;

/// The current DevOps Agent integration state for a service. Read operations
/// return this state.
pub const DevOpsAgentConfigurationView = struct {
    /// The ARN of the linked DevOps Agent Agent Space.
    agent_space_arn: ?[]const u8 = null,

    /// The identifier of the linked DevOps Agent Agent Space.
    agent_space_id: ?[]const u8 = null,

    /// The timestamp when the service successfully connected to the DevOps Agent
    /// Agent Space.
    connected_at: ?i64 = null,

    /// The URL of the DevOps Agent Operator App for the linked Agent Space. This
    /// URL is present when the connection status is CONNECTED.
    operator_app_url: ?[]const u8 = null,

    /// The AWS Region of the linked DevOps Agent Agent Space.
    region: ?[]const u8 = null,

    /// The connection status of the DevOps Agent integration for this service.
    /// Valid values:
    ///
    /// * CONNECTING - The service is being connected to the Agent Space.
    /// * CONNECTED - The service is connected to the Agent Space.
    /// * DISCONNECTED - The service is not connected to an Agent Space.
    /// * FAILED - The connection attempt failed. See statusReason for details.
    status: ?DevOpsAgentConnectionStatus = null,

    /// A human-readable explanation of the current connection status. This field
    /// explains the status when the connection fails.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_arn = "agentSpaceArn",
        .agent_space_id = "agentSpaceId",
        .connected_at = "connectedAt",
        .operator_app_url = "operatorAppUrl",
        .region = "region",
        .status = "status",
        .status_reason = "statusReason",
    };
};
