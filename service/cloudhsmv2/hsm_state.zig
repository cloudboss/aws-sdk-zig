pub const HsmState = enum {
    create_in_progress,
    active,
    degraded,
    delete_in_progress,
    deleted,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .degraded = "DEGRADED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .deleted = "DELETED",
    };
};
