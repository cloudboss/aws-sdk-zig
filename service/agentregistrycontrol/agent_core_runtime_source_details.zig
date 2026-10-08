const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AgentCoreRuntimeProtocolConfiguration = @import("agent_core_runtime_protocol_configuration.zig").AgentCoreRuntimeProtocolConfiguration;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

/// The source details for a registry record that was auto-detected from an
/// Amazon Bedrock AgentCore Runtime resource.
pub const AgentCoreRuntimeSourceDetails = struct {
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The protocol configuration of the AgentCore Runtime resource that the
    /// registry record was detected from.
    protocol_configuration: ?AgentCoreRuntimeProtocolConfiguration = null,

    /// The workload identity details for the AgentCore Runtime resource. Present
    /// when the runtime has a workload identity configured.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .workload_identity_details = "workloadIdentityDetails",
    };
};
