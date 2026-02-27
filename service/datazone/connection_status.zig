pub const ConnectionStatus = enum {
    creating,
    create_failed,
    deleting,
    delete_failed,
    ready,
    updating,
    update_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .ready = "READY",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleted = "DELETED",
    };
};
