/// The details on the Bedrock guardrail configuration.
pub const BedrockGuardrailConfiguration = struct {
    /// The unique guardrail id for the Bedrock guardrail configuration.
    identifier: []const u8,

    /// The guardrail version for the Bedrock guardrail configuration.
    version: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
        .version = "version",
    };
};
