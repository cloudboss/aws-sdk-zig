const GuardrailPiiEntityFilter = @import("guardrail_pii_entity_filter.zig").GuardrailPiiEntityFilter;
const GuardrailRegexFilter = @import("guardrail_regex_filter.zig").GuardrailRegexFilter;

/// The assessment for a Personally Identifiable Information (PII) policy.
pub const GuardrailSensitiveInformationPolicyAssessment = struct {
    /// The PII entities in the assessment.
    pii_entities: []const GuardrailPiiEntityFilter,

    /// The regex queries in the assessment.
    regexes: []const GuardrailRegexFilter,

    pub const json_field_names = .{
        .pii_entities = "piiEntities",
        .regexes = "regexes",
    };
};
