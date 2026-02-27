pub const LoggingConfigurationState = enum {
    creating,
    create_failed,
    deleting,
    delete_failed,
    updating,
    update_failed,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .active = "ACTIVE",
    };
};
