const GlossaryTermEnforcementDetail = @import("glossary_term_enforcement_detail.zig").GlossaryTermEnforcementDetail;
const MetadataFormEnforcementDetail = @import("metadata_form_enforcement_detail.zig").MetadataFormEnforcementDetail;

/// The details of a rule.
pub const RuleDetail = union(enum) {
    /// The enforcement details of a glossary term that's part of the metadata rule.
    glossary_term_enforcement_detail: ?GlossaryTermEnforcementDetail,
    /// The enforcement detail of the metadata form.
    metadata_form_enforcement_detail: ?MetadataFormEnforcementDetail,

    pub const json_field_names = .{
        .glossary_term_enforcement_detail = "glossaryTermEnforcementDetail",
        .metadata_form_enforcement_detail = "metadataFormEnforcementDetail",
    };
};
