const AutomationExecutionFilterKey = @import("automation_execution_filter_key.zig").AutomationExecutionFilterKey;

/// A filter used to match specific automation executions. This is used to limit
/// the scope of
/// Automation execution information returned.
pub const AutomationExecutionFilter = struct {
    /// One or more keys to limit the results.
    key: AutomationExecutionFilterKey,

    /// The values used to limit the execution information associated with the
    /// filter's key.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
