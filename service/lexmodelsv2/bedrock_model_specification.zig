const BedrockGuardrailConfiguration = @import("bedrock_guardrail_configuration.zig").BedrockGuardrailConfiguration;
const BedrockTraceStatus = @import("bedrock_trace_status.zig").BedrockTraceStatus;

/// Contains information about the Amazon Bedrock model used to interpret the
/// prompt used in descriptive bot building.
pub const BedrockModelSpecification = struct {
    /// The custom prompt used in the Bedrock model specification details.
    custom_prompt: ?[]const u8 = null,

    /// The guardrail configuration in the Bedrock model specification details.
    guardrail: ?BedrockGuardrailConfiguration = null,

    /// The ARN of the foundation model used in descriptive bot building.
    model_arn: []const u8,

    /// The Bedrock trace status in the Bedrock model specification details.
    trace_status: ?BedrockTraceStatus = null,

    pub const json_field_names = .{
        .custom_prompt = "customPrompt",
        .guardrail = "guardrail",
        .model_arn = "modelArn",
        .trace_status = "traceStatus",
    };
};
