pub const ManifestStatus = enum {
    active,
    draft,
    invalid,
    validating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draft = "DRAFT",
        .invalid = "INVALID",
        .validating = "VALIDATING",
    };
};
