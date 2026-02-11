pub const TableStatus = enum {
    creating,
    updating,
    deleting,
    active,
    inaccessible_encryption_credentials,
    archiving,
    archived,
    replication_not_authorized,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .inaccessible_encryption_credentials = "INACCESSIBLE_ENCRYPTION_CREDENTIALS",
        .archiving = "ARCHIVING",
        .archived = "ARCHIVED",
        .replication_not_authorized = "REPLICATION_NOT_AUTHORIZED",
    };
};
