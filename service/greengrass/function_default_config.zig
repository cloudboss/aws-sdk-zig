const FunctionDefaultExecutionConfig = @import("function_default_execution_config.zig").FunctionDefaultExecutionConfig;

/// The default configuration that applies to all Lambda functions in the group.
/// Individual Lambda functions can override these settings.
pub const FunctionDefaultConfig = struct {
    execution: ?FunctionDefaultExecutionConfig,

    pub const json_field_names = .{
        .execution = "Execution",
    };
};
