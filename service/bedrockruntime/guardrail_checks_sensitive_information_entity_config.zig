const GuardrailChecksSensitiveInformationEntityType = @import("guardrail_checks_sensitive_information_entity_type.zig").GuardrailChecksSensitiveInformationEntityType;

/// The configuration for a single sensitive information entity type to detect.
pub const GuardrailChecksSensitiveInformationEntityConfig = struct {
    /// The PII entity type to detect.
    @"type": GuardrailChecksSensitiveInformationEntityType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
