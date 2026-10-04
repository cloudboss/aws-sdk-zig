/// Contains information about a Bedrock guardrail associated with a finding.
pub const BedrockGuardrail = struct {
    /// The ARN of the Bedrock guardrail.
    arn: ?[]const u8 = null,

    /// The version of the Bedrock guardrail.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .version = "Version",
    };
};
