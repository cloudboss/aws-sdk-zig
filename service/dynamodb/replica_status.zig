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
};
