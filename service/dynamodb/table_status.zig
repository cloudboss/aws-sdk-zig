pub const TableStatus = enum {
    creating,
    updating,
    deleting,
    active,
    inaccessible_encryption_credentials,
    archiving,
    archived,
    replication_not_authorized,
};
