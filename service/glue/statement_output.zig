const StatementOutputData = @import("statement_output_data.zig").StatementOutputData;
const StatementState = @import("statement_state.zig").StatementState;

/// The code execution output in JSON format.
pub const StatementOutput = struct {
    /// The code execution output.
    data: ?StatementOutputData,

    /// The name of the error in the output.
    error_name: ?[]const u8,

    /// The error value of the output.
    error_value: ?[]const u8,

    /// The execution count of the output.
    execution_count: i32 = 0,

    /// The status of the code execution output.
    status: ?StatementState,

    /// The traceback of the output.
    traceback: ?[]const []const u8,

    pub const json_field_names = .{
        .data = "Data",
        .error_name = "ErrorName",
        .error_value = "ErrorValue",
        .execution_count = "ExecutionCount",
        .status = "Status",
        .traceback = "Traceback",
    };
};
