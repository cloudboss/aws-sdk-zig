/// You can enable a restart policy for each container defined in your task
/// definition, to
/// overcome transient failures faster and maintain task availability. When you
/// enable a
/// restart policy for a container, Amazon ECS can restart the container if it
/// exits,
/// without needing to replace the task. For more information, see [Restart
/// individual containers in Amazon ECS tasks with container restart
/// policies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-restart-policy.html) in
/// the *Amazon Elastic Container Service Developer Guide*.
pub const ContainerRestartPolicy = struct {
    /// Specifies whether a restart policy is enabled for the container.
    enabled: bool,

    /// A list of exit codes that Amazon ECS will ignore and not attempt a restart
    /// on. You can
    /// specify a maximum of 50 container exit codes. By default, Amazon ECS does
    /// not ignore any
    /// exit codes.
    ignored_exit_codes: ?[]const i32,

    /// A period of time (in seconds) that the container must run for before a
    /// restart can be
    /// attempted. A container can be restarted only once every
    /// `restartAttemptPeriod` seconds. If a container isn't able to run for this
    /// time period and exits early, it will not be restarted. You can set a minimum
    /// `restartAttemptPeriod` of 60 seconds and a maximum
    /// `restartAttemptPeriod` of 1800 seconds. By default, a container must run
    /// for 300 seconds before it can be restarted.
    restart_attempt_period: ?i32,

    pub const json_field_names = .{
        .enabled = "enabled",
        .ignored_exit_codes = "ignoredExitCodes",
        .restart_attempt_period = "restartAttemptPeriod",
    };
};
