pub const InstanceGroupStatus = enum {
    inservice,
    creating,
    updating,
    failed,
    degraded,
    systemupdating,
    deleting,

    pub const json_field_names = .{
        .inservice = "INSERVICE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .degraded = "DEGRADED",
        .systemupdating = "SYSTEMUPDATING",
        .deleting = "DELETING",
    };
};
