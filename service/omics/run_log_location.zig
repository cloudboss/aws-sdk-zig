/// The URI for the run log.
pub const RunLogLocation = struct {
    /// The log stream ARN for the engine log.
    engine_log_stream: ?[]const u8,

    /// The log stream ARN for the run log.
    run_log_stream: ?[]const u8,

    pub const json_field_names = .{
        .engine_log_stream = "engineLogStream",
        .run_log_stream = "runLogStream",
    };
};
