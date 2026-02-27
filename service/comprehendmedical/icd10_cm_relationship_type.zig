pub const ICD10CMRelationshipType = enum {
    overlap,
    system_organ_site,
    quality,

    pub const json_field_names = .{
        .overlap = "OVERLAP",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .quality = "QUALITY",
    };
};
