const ServiceDeploymentRollbackMonitorsStatus = @import("service_deployment_rollback_monitors_status.zig").ServiceDeploymentRollbackMonitorsStatus;

/// Information about the circuit breaker used to determine when a service
/// deployment has failed.
///
/// The deployment circuit breaker is the rolling update mechanism that
/// determines if the tasks reach a steady state. The deployment circuit breaker
/// has an option that will automatically roll back a failed deployment to the
/// last cpompleted service revision. For more information, see [How the Amazon
/// ECS deployment circuit breaker detects
/// failures](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-circuit-breaker.html) in the* Amazon ECS Developer Guide*.
pub const ServiceDeploymentCircuitBreaker = struct {
    /// The number of times the circuit breaker detected a service deploymeny
    /// failure.
    failure_count: i32 = 0,

    /// The circuit breaker status. Amazon ECS is not using the circuit breaker for
    /// service deployment failures when the status is `DISABLED`.
    status: ?ServiceDeploymentRollbackMonitorsStatus = null,

    /// The threshhold which determines that the service deployment failed.
    ///
    /// The deployment circuit breaker calculates the threshold value, and then uses
    /// the value to determine when to move the deployment to a FAILED state. The
    /// deployment circuit breaker has a minimum threshold of 3 and a maximum
    /// threshold of 200. and uses the values in the following formula to determine
    /// the deployment failure.
    ///
    /// `0.5 * desired task count`
    threshold: i32 = 0,

    pub const json_field_names = .{
        .failure_count = "failureCount",
        .status = "status",
        .threshold = "threshold",
    };
};
