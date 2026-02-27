pub const DomainControllerStatus = enum {
    creating,
    active,
    impaired,
    restoring,
    deleting,
    deleted,
    failed,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .impaired = "IMPAIRED",
        .restoring = "RESTORING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .updating = "UPDATING",
    };
};
