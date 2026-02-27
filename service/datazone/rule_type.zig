pub const RuleType = enum {
    metadata_form_enforcement,
    glossary_term_enforcement,

    pub const json_field_names = .{
        .metadata_form_enforcement = "METADATA_FORM_ENFORCEMENT",
        .glossary_term_enforcement = "GLOSSARY_TERM_ENFORCEMENT",
    };
};
