/// The enforcement details of a glossary term.
pub const GlossaryTermEnforcementDetail = struct {
    /// The ID of the required glossary term.
    required_glossary_term_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .required_glossary_term_ids = "requiredGlossaryTermIds",
    };
};
