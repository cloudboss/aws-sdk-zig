pub const NodegroupStatus = enum {
    creating,
    active,
    updating,
    deleting,
    create_failed,
    delete_failed,
    degraded,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
        .degraded = "DEGRADED",
    };
};
