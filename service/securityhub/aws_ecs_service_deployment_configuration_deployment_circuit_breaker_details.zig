/// Determines whether a service deployment fails if a service cannot reach a
/// steady state.
pub const AwsEcsServiceDeploymentConfigurationDeploymentCircuitBreakerDetails = struct {
    /// Whether to enable the deployment circuit breaker logic for the service.
    enable: ?bool,

    /// Whether to roll back the service if a service deployment fails. If rollback
    /// is enabled, when a service deployment fails, the service is rolled back to
    /// the last deployment that completed successfully.
    rollback: ?bool,

    pub const json_field_names = .{
        .enable = "Enable",
        .rollback = "Rollback",
    };
};
