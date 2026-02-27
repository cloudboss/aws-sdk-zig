const GuardrailPiiEntityConfig = @import("guardrail_pii_entity_config.zig").GuardrailPiiEntityConfig;
const GuardrailRegexConfig = @import("guardrail_regex_config.zig").GuardrailRegexConfig;

/// Contains details about PII entities and regular expressions to configure for
/// the guardrail.
pub const GuardrailSensitiveInformationPolicyConfig = struct {
    /// A list of PII entities to configure to the guardrail.
    pii_entities_config: ?[]const GuardrailPiiEntityConfig,

    /// A list of regular expressions to configure to the guardrail.
    regexes_config: ?[]const GuardrailRegexConfig,

    pub const json_field_names = .{
        .pii_entities_config = "piiEntitiesConfig",
        .regexes_config = "regexesConfig",
    };
};
