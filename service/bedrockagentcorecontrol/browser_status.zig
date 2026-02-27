pub const BrowserStatus = enum {
    creating,
    create_failed,
    ready,
    deleting,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .ready = "READY",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };
};
