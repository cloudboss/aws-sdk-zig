pub const AddonStatus = enum {
    creating,
    active,
    create_failed,
    updating,
    deleting,
    delete_failed,
    degraded,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .degraded = "DEGRADED",
        .update_failed = "UPDATE_FAILED",
    };
};
