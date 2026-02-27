pub const NodeStatus = enum {
    creating,
    available,
    unhealthy,
    create_failed,
    updating,
    deleting,
    deleted,
    failed,
    inaccessible_encryption_key,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .unhealthy = "UNHEALTHY",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .inaccessible_encryption_key = "INACCESSIBLE_ENCRYPTION_KEY",
    };
};
