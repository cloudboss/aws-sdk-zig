pub const DomainStatus = enum {
    active,
    creation_in_progress,
    creation_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_failed = "CREATION_FAILED",
    };
};
