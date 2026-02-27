pub const TableStatus = enum {
    active,
    creating,
    updating,
    deleting,
    deleted,
    restoring,
    inaccessible_encryption_credentials,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .restoring = "RESTORING",
        .inaccessible_encryption_credentials = "INACCESSIBLE_ENCRYPTION_CREDENTIALS",
    };
};
