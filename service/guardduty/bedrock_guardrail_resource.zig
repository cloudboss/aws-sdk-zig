const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const GuardrailSource = @import("guardrail_source.zig").GuardrailSource;

/// Contains details about an Amazon Bedrock guardrail evaluated during a model
/// invocation.
pub const BedrockGuardrailResource = struct {
    /// Indicates whether the guardrail intervened during the model invocation.
    guardrail_action: ?GuardrailAction = null,

    /// Indicates whether the guardrail was applied on the input or output of the
    /// model invocation.
    guardrail_source: ?GuardrailSource = null,

    /// The version of the Amazon Bedrock guardrail. Valid values are a numeric
    /// version, `DRAFT`, or `ENFORCED`.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .guardrail_action = "GuardrailAction",
        .guardrail_source = "GuardrailSource",
        .version = "Version",
    };
};
