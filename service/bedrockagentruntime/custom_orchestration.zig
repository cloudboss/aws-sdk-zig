const OrchestrationExecutor = @import("orchestration_executor.zig").OrchestrationExecutor;

/// Contains details of the custom orchestration configured for the agent.
pub const CustomOrchestration = struct {
    /// The structure of the executor invoking the actions in custom orchestration.
    executor: ?OrchestrationExecutor,

    pub const json_field_names = .{
        .executor = "executor",
    };
};
