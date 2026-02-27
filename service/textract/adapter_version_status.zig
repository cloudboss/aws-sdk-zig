pub const AdapterVersionStatus = enum {
    active,
    at_risk,
    deprecated,
    creation_error,
    creation_in_progress,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .at_risk = "AT_RISK",
        .deprecated = "DEPRECATED",
        .creation_error = "CREATION_ERROR",
        .creation_in_progress = "CREATION_IN_PROGRESS",
    };
};
