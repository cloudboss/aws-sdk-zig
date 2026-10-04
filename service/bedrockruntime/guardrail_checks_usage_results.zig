const GuardrailChecksContentFilterUsage = @import("guardrail_checks_content_filter_usage.zig").GuardrailChecksContentFilterUsage;
const GuardrailChecksPromptAttackUsage = @import("guardrail_checks_prompt_attack_usage.zig").GuardrailChecksPromptAttackUsage;
const GuardrailChecksSensitiveInformationUsage = @import("guardrail_checks_sensitive_information_usage.zig").GuardrailChecksSensitiveInformationUsage;

/// The text unit usage for the guardrail checks evaluation, organized by check
/// type.
pub const GuardrailChecksUsageResults = struct {
    /// The text unit usage for the content filter check.
    content_filter: ?GuardrailChecksContentFilterUsage = null,

    /// The text unit usage for the prompt attack check.
    prompt_attack: ?GuardrailChecksPromptAttackUsage = null,

    /// The text unit usage for the sensitive information check.
    sensitive_information: ?GuardrailChecksSensitiveInformationUsage = null,

    pub const json_field_names = .{
        .content_filter = "contentFilter",
        .prompt_attack = "promptAttack",
        .sensitive_information = "sensitiveInformation",
    };
};
