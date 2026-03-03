/// Contains statistics for a session.
pub const SessionStatistics = struct {
    /// The data processing unit execution time for a session in milliseconds.
    dpu_execution_in_millis: ?i64 = null,

    pub const json_field_names = .{
        .dpu_execution_in_millis = "DpuExecutionInMillis",
    };
};
