pub const DetectorVersionStatus = enum {
    draft,
    active,
    inactive,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
    };
};
