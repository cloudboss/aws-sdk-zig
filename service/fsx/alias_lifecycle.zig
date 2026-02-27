pub const AliasLifecycle = enum {
    available,
    creating,
    deleting,
    create_failed,
    delete_failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
