/// Configuration for a Bedrock guardrail applied during agentic retrieval.
pub const AgenticRetrieveBedrockGuardrailConfiguration = struct {
    /// The unique identifier of the guardrail.
    guardrail_id: []const u8,

    /// The version of the guardrail to use.
    guardrail_version: []const u8,

    pub const json_field_names = .{
        .guardrail_id = "guardrailId",
        .guardrail_version = "guardrailVersion",
    };
};
