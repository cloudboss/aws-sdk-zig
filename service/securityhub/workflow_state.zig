pub const WorkflowState = enum {
    new,
    assigned,
    in_progress,
    deferred,
    resolved,

    pub const json_field_names = .{
        .new = "NEW",
        .assigned = "ASSIGNED",
        .in_progress = "IN_PROGRESS",
        .deferred = "DEFERRED",
        .resolved = "RESOLVED",
    };
};
