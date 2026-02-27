pub const FlowStatus = enum {
    active,
    deprecated,
    deleted,
    draft,
    errored,
    suspended,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deprecated = "DEPRECATED",
        .deleted = "DELETED",
        .draft = "DRAFT",
        .errored = "ERRORED",
        .suspended = "SUSPENDED",
    };
};
