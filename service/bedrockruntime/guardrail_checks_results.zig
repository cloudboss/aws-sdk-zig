const GuardrailChecksContentFilterResult = @import("guardrail_checks_content_filter_result.zig").GuardrailChecksContentFilterResult;
const GuardrailChecksPromptAttackResult = @import("guardrail_checks_prompt_attack_result.zig").GuardrailChecksPromptAttackResult;
const GuardrailChecksSensitiveInformationResult = @import("guardrail_checks_sensitive_information_result.zig").GuardrailChecksSensitiveInformationResult;

/// The results from the guardrail checks evaluation, organized by check type.
pub const GuardrailChecksResults = struct {
    /// The content filter check results.
    content_filter: ?GuardrailChecksContentFilterResult = null,

    /// The prompt attack check results.
    prompt_attack: ?GuardrailChecksPromptAttackResult = null,

    /// The sensitive information check results.
    sensitive_information: ?GuardrailChecksSensitiveInformationResult = null,

    pub const json_field_names = .{
        .content_filter = "contentFilter",
        .prompt_attack = "promptAttack",
        .sensitive_information = "sensitiveInformation",
    };
};
