const DaemonDeploymentRollbackMonitorsStatus = @import("daemon_deployment_rollback_monitors_status.zig").DaemonDeploymentRollbackMonitorsStatus;

/// Information about the circuit breaker used to determine when a daemon
/// deployment has failed.
pub const DaemonCircuitBreaker = struct {
    /// The number of times the circuit breaker detected a daemon deployment
    /// failure.
    failure_count: i32 = 0,

    /// The circuit breaker status. Amazon ECS is not using the circuit breaker for
    /// daemon deployment failures when the status is `DISABLED`.
    status: ?DaemonDeploymentRollbackMonitorsStatus = null,

    /// The threshold which determines that the daemon deployment failed.
    threshold: i32 = 0,

    pub const json_field_names = .{
        .failure_count = "failureCount",
        .status = "status",
        .threshold = "threshold",
    };
};
