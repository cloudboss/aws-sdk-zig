const GuardrailPiiEntityFilter = @import("guardrail_pii_entity_filter.zig").GuardrailPiiEntityFilter;
const GuardrailRegexFilter = @import("guardrail_regex_filter.zig").GuardrailRegexFilter;

/// The details of the sensitive policy assessment used in the Guardrail.
pub const GuardrailSensitiveInformationPolicyAssessment = struct {
    /// The details of the PII entities used in the sensitive policy assessment for
    /// the Guardrail.
    pii_entities: ?[]const GuardrailPiiEntityFilter = null,

    /// The details of the regexes used in the sensitive policy assessment for the
    /// Guardrail.
    regexes: ?[]const GuardrailRegexFilter = null,

    pub const json_field_names = .{
        .pii_entities = "piiEntities",
        .regexes = "regexes",
    };
};
