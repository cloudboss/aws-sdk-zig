const RecoveryPlanServer = @import("recovery_plan_server.zig").RecoveryPlanServer;

/// Configuration for a `SERVER` type step.
pub const ServerStepConfiguration = struct {
    /// The list of servers to recover in this step.
    servers: []const RecoveryPlanServer,

    pub const json_field_names = .{
        .servers = "servers",
    };
};
