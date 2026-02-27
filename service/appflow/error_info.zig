/// Provides details in the event of a failed flow, including the failure count
/// and the
/// related error messages.
pub const ErrorInfo = struct {
    /// Specifies the error message that appears if a flow fails.
    execution_message: ?[]const u8,

    /// Specifies the failure count for the attempted flow.
    put_failures_count: ?i64,

    pub const json_field_names = .{
        .execution_message = "executionMessage",
        .put_failures_count = "putFailuresCount",
    };
};
