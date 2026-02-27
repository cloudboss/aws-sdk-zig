pub const ExecutionMode = enum {
    queued,
    superseded,
    parallel,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .superseded = "SUPERSEDED",
        .parallel = "PARALLEL",
    };
};
