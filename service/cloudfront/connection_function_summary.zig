const FunctionConfig = @import("function_config.zig").FunctionConfig;
const FunctionStage = @import("function_stage.zig").FunctionStage;

/// A connection function summary.
pub const ConnectionFunctionSummary = struct {
    /// The connection function Amazon Resource Name (ARN).
    connection_function_arn: []const u8,

    connection_function_config: FunctionConfig,

    /// The connection function created time.
    created_time: i64,

    /// The connection function ID.
    id: []const u8,

    /// The connection function last modified time.
    last_modified_time: i64,

    /// The connection function name.
    name: []const u8,

    /// The connection function stage.
    stage: FunctionStage,

    /// The connection function status.
    status: []const u8,
};
