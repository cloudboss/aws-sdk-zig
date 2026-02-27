const GuardrailPiiEntity = @import("guardrail_pii_entity.zig").GuardrailPiiEntity;
const GuardrailRegex = @import("guardrail_regex.zig").GuardrailRegex;

/// Contains details about PII entities and regular expressions configured for
/// the guardrail.
pub const GuardrailSensitiveInformationPolicy = struct {
    /// The list of PII entities configured for the guardrail.
    pii_entities: ?[]const GuardrailPiiEntity,

    /// The list of regular expressions configured for the guardrail.
    regexes: ?[]const GuardrailRegex,

    pub const json_field_names = .{
        .pii_entities = "piiEntities",
        .regexes = "regexes",
    };
};
