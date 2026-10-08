const AgentCoreGatewaySourceDetails = @import("agent_core_gateway_source_details.zig").AgentCoreGatewaySourceDetails;
const AgentCoreRuntimeSourceDetails = @import("agent_core_runtime_source_details.zig").AgentCoreRuntimeSourceDetails;

/// The details about the upstream source from which a registry record was
/// detected. Exactly one member is populated, corresponding to the source type.
pub const SourceDetails = union(enum) {
    /// The source details for a registry record that was auto-detected from an
    /// Amazon Bedrock AgentCore Gateway resource. Populated when the source type is
    /// `AWS::BedrockAgentCore::Gateway`.
    agentcore_gateway: ?AgentCoreGatewaySourceDetails,
    /// The source details for a registry record that was auto-detected from an
    /// Amazon Bedrock AgentCore Runtime resource. Populated when the source type is
    /// `AWS::BedrockAgentCore::Runtime`.
    agentcore_runtime: ?AgentCoreRuntimeSourceDetails,

    pub const json_field_names = .{
        .agentcore_gateway = "agentcoreGateway",
        .agentcore_runtime = "agentcoreRuntime",
    };
};
