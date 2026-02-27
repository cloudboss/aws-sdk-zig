const AgentStatus = @import("agent_status.zig").AgentStatus;
const AuditResults = @import("audit_results.zig").AuditResults;
const UplinkDataflowDetails = @import("uplink_dataflow_details.zig").UplinkDataflowDetails;

/// Details for an uplink agent endpoint
pub const UplinkAwsGroundStationAgentEndpointDetails = struct {
    /// Status of the agent associated with the uplink dataflow endpoint
    agent_status: ?AgentStatus,

    /// Health audit results for the uplink dataflow endpoint
    audit_results: ?AuditResults,

    /// Dataflow details for the uplink endpoint
    dataflow_details: UplinkDataflowDetails,

    /// Uplink dataflow endpoint name
    name: []const u8,

    pub const json_field_names = .{
        .agent_status = "agentStatus",
        .audit_results = "auditResults",
        .dataflow_details = "dataflowDetails",
        .name = "name",
    };
};
