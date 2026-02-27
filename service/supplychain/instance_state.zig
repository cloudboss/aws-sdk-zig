pub const InstanceState = enum {
    initializing,
    active,
    create_failed,
    delete_failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .active = "ACTIVE",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
