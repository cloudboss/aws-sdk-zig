pub const AnalysisStatus = enum {
    running,
    complete,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
