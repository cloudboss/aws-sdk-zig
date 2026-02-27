pub const DirectoryStage = enum {
    requested,
    creating,
    created,
    active,
    inoperable,
    impaired,
    restoring,
    restorefailed,
    deleting,
    deleted,
    failed,
    updating,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .creating = "CREATING",
        .created = "CREATED",
        .active = "ACTIVE",
        .inoperable = "INOPERABLE",
        .impaired = "IMPAIRED",
        .restoring = "RESTORING",
        .restorefailed = "RESTOREFAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .updating = "UPDATING",
    };
};
