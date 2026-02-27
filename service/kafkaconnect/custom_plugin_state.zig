pub const CustomPluginState = enum {
    creating,
    create_failed,
    active,
    updating,
    update_failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
    };
};
