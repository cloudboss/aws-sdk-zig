const ConnectionFunctionSummary = @import("connection_function_summary.zig").ConnectionFunctionSummary;

/// A connection function test result.
pub const ConnectionFunctionTestResult = struct {
    /// The connection function compute utilization.
    compute_utilization: ?[]const u8,

    /// The connection function error message.
    connection_function_error_message: ?[]const u8,

    /// The connection function execution logs.
    connection_function_execution_logs: ?[]const []const u8,

    /// The connection function output.
    connection_function_output: ?[]const u8,

    /// The connection function summary.
    connection_function_summary: ?ConnectionFunctionSummary,
};
