pub const NetworkStatus = enum {
    creating,
    available,
    create_failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .create_failed = "CREATE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
