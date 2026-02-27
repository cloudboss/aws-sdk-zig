/// Instructions on when and how to check the health of a support container in a
/// container
/// fleet. These properties override any Docker health checks that are set in
/// the container image.
/// For more information on container health checks, see [HealthCheck
/// command](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html#ECS-Type-HealthCheck-command) in the *Amazon Elastic Container Service API*. Game server
/// containers don't have a health check parameter; Amazon GameLift Servers
/// automatically handles health checks
/// for these containers.
///
/// The following example instructs the container to initiate a health check
/// command every 60
/// seconds and wait 10 seconds for it to succeed. If it fails, retry the
/// command 3 times before
/// flagging the container as unhealthy. It also tells the container to wait 100
/// seconds after
/// launch before counting failed health checks.
///
/// `{"Command": [ "CMD-SHELL", "ps cax | grep "processmanager" || exit 1" ],
/// "Interval":
/// 60, "Timeout": 10, "Retries": 3, "StartPeriod": 100 }`
///
/// **Part of:**
/// [SupportContainerDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinition.html), [SupportContainerDefinitionInput](https://docs.aws.amazon.com/gamelift/latest/apireference/API_SupportContainerDefinitionInput.html)
pub const ContainerHealthCheck = struct {
    /// A string array that specifies the command that the container runs to
    /// determine if it's
    /// healthy.
    command: []const []const u8,

    /// The time period (in seconds) between each health check.
    interval: ?i32,

    /// The number of times to retry a failed health check before flagging the
    /// container
    /// unhealthy. The first run of the command does not count as a retry.
    retries: ?i32,

    /// The optional grace period (in seconds) to give a container time to bootstrap
    /// before the
    /// first failed health check counts toward the number of retries.
    start_period: ?i32,

    /// The time period (in seconds) to wait for a health check to succeed before
    /// counting a
    /// failed health check.
    timeout: ?i32,

    pub const json_field_names = .{
        .command = "Command",
        .interval = "Interval",
        .retries = "Retries",
        .start_period = "StartPeriod",
        .timeout = "Timeout",
    };
};
