const FunctionIsolationMode = @import("function_isolation_mode.zig").FunctionIsolationMode;
const FunctionRunAsConfig = @import("function_run_as_config.zig").FunctionRunAsConfig;

/// Configuration information that specifies how a Lambda function runs.
pub const FunctionDefaultExecutionConfig = struct {
    isolation_mode: ?FunctionIsolationMode,

    run_as: ?FunctionRunAsConfig,

    pub const json_field_names = .{
        .isolation_mode = "IsolationMode",
        .run_as = "RunAs",
    };
};
