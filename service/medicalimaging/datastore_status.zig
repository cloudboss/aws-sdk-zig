pub const DatastoreStatus = enum {
    creating,
    create_failed,
    active,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
