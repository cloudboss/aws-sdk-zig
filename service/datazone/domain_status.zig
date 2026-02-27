pub const DomainStatus = enum {
    creating,
    available,
    creation_failed,
    deleting,
    deleted,
    deletion_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .creation_failed = "CREATION_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .deletion_failed = "DELETION_FAILED",
    };
};
