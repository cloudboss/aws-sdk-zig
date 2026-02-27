pub const MemberStatus = enum {
    creating,
    available,
    create_failed,
    updating,
    deleting,
    deleted,
    inaccessible_encryption_key,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .inaccessible_encryption_key = "INACCESSIBLE_ENCRYPTION_KEY",
    };
};
