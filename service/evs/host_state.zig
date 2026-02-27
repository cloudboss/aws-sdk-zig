pub const HostState = enum {
    creating,
    created,
    updating,
    deleting,
    deleted,
    create_failed,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
