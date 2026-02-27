pub const DetectorModelVersionStatus = enum {
    active,
    activating,
    inactive,
    deprecated,
    draft,
    paused,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .activating = "ACTIVATING",
        .inactive = "INACTIVE",
        .deprecated = "DEPRECATED",
        .draft = "DRAFT",
        .paused = "PAUSED",
        .failed = "FAILED",
    };
};
