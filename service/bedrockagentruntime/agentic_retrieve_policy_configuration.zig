const AgenticRetrieveBedrockGuardrailConfiguration = @import("agentic_retrieve_bedrock_guardrail_configuration.zig").AgenticRetrieveBedrockGuardrailConfiguration;

/// Policy configuration for agentic retrieval.
pub const AgenticRetrievePolicyConfiguration = struct {
    /// Configuration for Bedrock guardrails to apply during retrieval.
    bedrock_guardrail_configuration: ?AgenticRetrieveBedrockGuardrailConfiguration = null,

    pub const json_field_names = .{
        .bedrock_guardrail_configuration = "bedrockGuardrailConfiguration",
    };
};
