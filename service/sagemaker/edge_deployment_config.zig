const FailureHandlingPolicy = @import("failure_handling_policy.zig").FailureHandlingPolicy;

/// Contains information about the configuration of a deployment.
pub const EdgeDeploymentConfig = struct {
    /// Toggle that determines whether to rollback to previous configuration if the
    /// current deployment fails. By default this is turned on. You may turn this
    /// off if you want to investigate the errors yourself.
    failure_handling_policy: FailureHandlingPolicy,

    pub const json_field_names = .{
        .failure_handling_policy = "FailureHandlingPolicy",
    };
};
