const RecoveryPlanExecutionServer = @import("recovery_plan_execution_server.zig").RecoveryPlanExecutionServer;

/// Configuration for a `SERVER` type execution step.
pub const ExecutionServerStepConfiguration = struct {
    /// The list of servers in this execution step.
    servers: []const RecoveryPlanExecutionServer,

    pub const json_field_names = .{
        .servers = "servers",
    };
};
