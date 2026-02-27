const AgentStatus = @import("agent_status.zig").AgentStatus;
const AuditResults = @import("audit_results.zig").AuditResults;
const DownlinkDataflowDetails = @import("downlink_dataflow_details.zig").DownlinkDataflowDetails;

/// Details for a downlink agent endpoint
pub const DownlinkAwsGroundStationAgentEndpointDetails = struct {
    /// Status of the agent associated with the downlink dataflow endpoint
    agent_status: ?AgentStatus,

    /// Health audit results for the downlink dataflow endpoint
    audit_results: ?AuditResults,

    /// Dataflow details for the downlink endpoint
    dataflow_details: DownlinkDataflowDetails,

    /// Downlink dataflow endpoint name
    name: []const u8,

    pub const json_field_names = .{
        .agent_status = "agentStatus",
        .audit_results = "auditResults",
        .dataflow_details = "dataflowDetails",
        .name = "name",
    };
};
