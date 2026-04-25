/// The deployment circuit breaker can only be used for services using the
/// rolling update (`ECS`) deployment type.
///
/// The **deployment circuit breaker** determines whether a service deployment
/// will fail if the service can't reach a steady state. If it is turned on, a
/// service deployment will transition to a failed state and stop launching new
/// tasks. You can also configure Amazon ECS to roll back your service to the
/// last completed deployment after a failure. For more information, see
/// [Rolling
/// update](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the *Amazon Elastic Container Service Developer Guide*.
///
/// For more information about API failure reasons, see [API failure
/// reasons](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/api_failures_messages.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const DeploymentCircuitBreaker = struct {
    /// Determines whether to use the deployment circuit breaker logic for the
    /// service.
    enable: bool = false,

    /// Determines whether to configure Amazon ECS to roll back the service if a
    /// service deployment fails. If rollback is on, when a service deployment
    /// fails, the service is rolled back to the last deployment that completed
    /// successfully.
    rollback: bool = false,

    pub const json_field_names = .{
        .enable = "enable",
        .rollback = "rollback",
    };
};
