pub const ApplicationStatus = enum {
    creating,
    updating,
    deleting,
    active,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
