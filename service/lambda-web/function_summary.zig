const FunctionState = @import("function_state.zig").FunctionState;

/// A summary of a web function.
pub const FunctionSummary = struct {
    /// The date and time the web function was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the web function.
    function_arn: []const u8,

    /// The name of the web function.
    function_name: []const u8,

    /// The current state of the web function.
    state: FunctionState,

    /// The reason for the current state of the web function.
    state_reason: []const u8,

    /// The date and time the web function was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .function_arn = "functionArn",
        .function_name = "functionName",
        .state = "state",
        .state_reason = "stateReason",
        .updated_at = "updatedAt",
    };
};
