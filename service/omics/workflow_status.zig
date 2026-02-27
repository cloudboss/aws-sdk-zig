pub const WorkflowStatus = enum {
    creating,
    active,
    updating,
    deleted,
    failed,
    inactive,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .inactive = "INACTIVE",
    };
};
