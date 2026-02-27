pub const ClusterAutoScalingStatus = enum {
    inservice,
    failed,
    creating,
    deleting,

    pub const json_field_names = .{
        .inservice = "INSERVICE",
        .failed = "FAILED",
        .creating = "CREATING",
        .deleting = "DELETING",
    };
};
