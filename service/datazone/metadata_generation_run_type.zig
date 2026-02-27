pub const MetadataGenerationRunType = enum {
    business_descriptions,
    business_names,
    business_glossary_associations,

    pub const json_field_names = .{
        .business_descriptions = "BUSINESS_DESCRIPTIONS",
        .business_names = "BUSINESS_NAMES",
        .business_glossary_associations = "BUSINESS_GLOSSARY_ASSOCIATIONS",
    };
};
