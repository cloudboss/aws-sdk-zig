const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AgentCoreGatewayProtocolType = @import("agent_core_gateway_protocol_type.zig").AgentCoreGatewayProtocolType;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

/// The source details for a registry record that was auto-detected from an
/// Amazon Bedrock AgentCore Gateway resource.
pub const AgentCoreGatewaySourceDetails = struct {
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer configured on the AgentCore Gateway resource that the
    /// registry record was detected from.
    authorizer_type: ?[]const u8 = null,

    /// The protocol type of the AgentCore Gateway resource that the registry record
    /// was detected from, for example `MCP`.
    protocol_type: ?AgentCoreGatewayProtocolType = null,

    /// The workload identity details for the AgentCore Gateway resource. Present
    /// when the gateway has a workload identity configured.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .protocol_type = "protocolType",
        .workload_identity_details = "workloadIdentityDetails",
    };
};
