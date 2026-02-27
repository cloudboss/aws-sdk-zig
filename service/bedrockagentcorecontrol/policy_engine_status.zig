pub const PolicyEngineStatus = enum {
    creating,
    active,
    updating,
    deleting,
    create_failed,
    update_failed,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
