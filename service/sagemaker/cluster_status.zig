pub const ClusterStatus = enum {
    creating,
    deleting,
    failed,
    inservice,
    rollingback,
    systemupdating,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .inservice = "INSERVICE",
        .rollingback = "ROLLINGBACK",
        .systemupdating = "SYSTEMUPDATING",
        .updating = "UPDATING",
    };
};
