pub const RouteAnalysisStatus = enum {
    running,
    completed,
    failed,

    pub const json_field_names = .{
        .running = "running",
        .completed = "completed",
        .failed = "failed",
    };
};
