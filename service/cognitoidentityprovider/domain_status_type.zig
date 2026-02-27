pub const DomainStatusType = enum {
    creating,
    deleting,
    updating,
    active,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
