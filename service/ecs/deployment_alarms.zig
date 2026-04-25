/// One of the methods which provide a way for you to quickly identify when a
/// deployment has failed, and then to optionally roll back the failure to the
/// last working deployment.
///
/// When the alarms are generated, Amazon ECS sets the service deployment to
/// failed. Set the rollback parameter to have Amazon ECS to roll back your
/// service to the last completed deployment after a failure.
///
/// You can only use the `DeploymentAlarms` method to detect failures when the
/// `DeploymentController` is set to `ECS`.
///
/// For more information, see [Rolling
/// update](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the * Amazon Elastic Container Service Developer Guide* .
pub const DeploymentAlarms = struct {
    /// One or more CloudWatch alarm names. Use a "," to separate the alarms.
    alarm_names: []const []const u8,

    /// Determines whether to use the CloudWatch alarm option in the service
    /// deployment process.
    enable: bool = false,

    /// Determines whether to configure Amazon ECS to roll back the service if a
    /// service deployment fails. If rollback is used, when a service deployment
    /// fails, the service is rolled back to the last deployment that completed
    /// successfully.
    rollback: bool = false,

    pub const json_field_names = .{
        .alarm_names = "alarmNames",
        .enable = "enable",
        .rollback = "rollback",
    };
};
