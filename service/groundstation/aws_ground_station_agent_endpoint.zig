const AgentStatus = @import("agent_status.zig").AgentStatus;
const AuditResults = @import("audit_results.zig").AuditResults;
const ConnectionDetails = @import("connection_details.zig").ConnectionDetails;
const RangedConnectionDetails = @import("ranged_connection_details.zig").RangedConnectionDetails;

/// Information about AwsGroundStationAgentEndpoint.
pub const AwsGroundStationAgentEndpoint = struct {
    /// The status of AgentEndpoint.
    agent_status: ?AgentStatus = null,

    /// The results of the audit.
    audit_results: ?AuditResults = null,

    /// The egress address of AgentEndpoint.
    egress_address: ConnectionDetails,

    /// The ingress address of AgentEndpoint.
    ingress_address: RangedConnectionDetails,

    /// Name string associated with AgentEndpoint. Used as a human-readable
    /// identifier for AgentEndpoint.
    name: []const u8,

    pub const json_field_names = .{
        .agent_status = "agentStatus",
        .audit_results = "auditResults",
        .egress_address = "egressAddress",
        .ingress_address = "ingressAddress",
        .name = "name",
    };
};
