pub const InstanceStatus = enum {
    creation_in_progress,
    active,
    creation_failed,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .active = "ACTIVE",
        .creation_failed = "CREATION_FAILED",
    };
};
