const GuardrailChecksSensitiveInformationEntityConfig = @import("guardrail_checks_sensitive_information_entity_config.zig").GuardrailChecksSensitiveInformationEntityConfig;

/// The configuration for the sensitive information check, specifying which
/// entity types to detect.
pub const GuardrailChecksSensitiveInformationConfig = struct {
    /// The sensitive information entity types to detect.
    entities: []const GuardrailChecksSensitiveInformationEntityConfig,

    pub const json_field_names = .{
        .entities = "entities",
    };
};
