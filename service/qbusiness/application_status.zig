pub const ApplicationStatus = enum {
    creating,
    active,
    deleting,
    failed,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
    };
};
