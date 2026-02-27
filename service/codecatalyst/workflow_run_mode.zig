pub const WorkflowRunMode = enum {
    queued,
    parallel,
    superseded,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .parallel = "PARALLEL",
        .superseded = "SUPERSEDED",
    };
};
