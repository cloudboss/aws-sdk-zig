pub const KxClusterStatus = enum {
    pending,
    creating,
    create_failed,
    running,
    updating,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .running = "RUNNING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };
};
