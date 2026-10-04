const ContentPolicyFilter = @import("content_policy_filter.zig").ContentPolicyFilter;
const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const BedrockGuardrail = @import("bedrock_guardrail.zig").BedrockGuardrail;
const GuardrailSource = @import("guardrail_source.zig").GuardrailSource;

/// Contains information about the Bedrock guardrail that was involved in a
/// finding.
pub const BedrockGuardrailDetails = struct {
    /// The list of content policy filters that matched during the guardrail
    /// evaluation.
    content_policy_filters: ?[]const ContentPolicyFilter = null,

    /// Indicates whether the guardrail intervened or not.
    guardrail_action: ?GuardrailAction = null,

    /// The ARN of the Bedrock guardrail. This field is deprecated. Use the
    /// `guardrails` list instead.
    guardrail_arn: ?[]const u8 = null,

    /// The list of Bedrock guardrails associated with the finding.
    guardrails: ?[]const BedrockGuardrail = null,

    /// Indicates whether the guardrail was applied on the input or output of the
    /// model invocation.
    guardrail_source: ?GuardrailSource = null,

    /// The version of the Bedrock guardrail. This field is deprecated. Use the
    /// `guardrails` list instead.
    guardrail_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_policy_filters = "ContentPolicyFilters",
        .guardrail_action = "GuardrailAction",
        .guardrail_arn = "GuardrailArn",
        .guardrails = "Guardrails",
        .guardrail_source = "GuardrailSource",
        .guardrail_version = "GuardrailVersion",
    };
};
