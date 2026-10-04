const GuardrailChecksContentFilterConfig = @import("guardrail_checks_content_filter_config.zig").GuardrailChecksContentFilterConfig;
const GuardrailChecksPromptAttackConfig = @import("guardrail_checks_prompt_attack_config.zig").GuardrailChecksPromptAttackConfig;
const GuardrailChecksSensitiveInformationConfig = @import("guardrail_checks_sensitive_information_config.zig").GuardrailChecksSensitiveInformationConfig;

/// The configuration for inline guardrail checks. Specify one or more check
/// types to run against the messages.
pub const GuardrailChecksConfig = struct {
    /// The content filter check configuration.
    content_filter: ?GuardrailChecksContentFilterConfig = null,

    /// The prompt attack check configuration.
    prompt_attack: ?GuardrailChecksPromptAttackConfig = null,

    /// The sensitive information check configuration.
    sensitive_information: ?GuardrailChecksSensitiveInformationConfig = null,

    pub const json_field_names = .{
        .content_filter = "contentFilter",
        .prompt_attack = "promptAttack",
        .sensitive_information = "sensitiveInformation",
    };
};
