const StepExecutionFilterKey = @import("step_execution_filter_key.zig").StepExecutionFilterKey;

/// A filter to limit the amount of step execution information returned by the
/// call.
pub const StepExecutionFilter = struct {
    /// One or more keys to limit the results.
    key: StepExecutionFilterKey,

    /// The values of the filter key.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
