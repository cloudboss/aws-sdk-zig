pub const ReplicaStatus = enum {
    creating,
    creation_failed,
    updating,
    deleting,
    active,
    region_disabled,
    inaccessible_encryption_credentials,
    archiving,
    archived,
    replication_not_authorized,

    pub const json_field_names = .{
        .creating = "CREATING",
        .creation_failed = "CREATION_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .region_disabled = "REGION_DISABLED",
        .inaccessible_encryption_credentials = "INACCESSIBLE_ENCRYPTION_CREDENTIALS",
        .archiving = "ARCHIVING",
        .archived = "ARCHIVED",
        .replication_not_authorized = "REPLICATION_NOT_AUTHORIZED",
    };
};
