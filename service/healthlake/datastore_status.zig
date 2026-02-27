pub const DatastoreStatus = enum {
    creating,
    active,
    deleting,
    deleted,
    create_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .create_failed = "CREATE_FAILED",
    };
};
