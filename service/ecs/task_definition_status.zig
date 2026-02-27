pub const TaskDefinitionStatus = enum {
    active,
    inactive,
    delete_in_progress,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };
};
