const OrchestrationExecutor = @import("orchestration_executor.zig").OrchestrationExecutor;

/// Details of custom orchestration.
pub const CustomOrchestration = struct {
    /// The structure of the executor invoking the actions in custom orchestration.
    executor: ?OrchestrationExecutor = null,

    pub const json_field_names = .{
        .executor = "executor",
    };
};
