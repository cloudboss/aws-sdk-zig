/// Contains statistics for a notebook calculation.
pub const CalculationStatistics = struct {
    /// The data processing unit execution time in milliseconds for the calculation.
    dpu_execution_in_millis: ?i64 = null,

    /// The progress of the calculation.
    progress: ?[]const u8 = null,

    pub const json_field_names = .{
        .dpu_execution_in_millis = "DpuExecutionInMillis",
        .progress = "Progress",
    };
};
