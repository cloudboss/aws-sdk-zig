pub const ResourceGroupState = enum {
    creating,
    create_complete,
    create_failed,
    updating,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
    };
};
