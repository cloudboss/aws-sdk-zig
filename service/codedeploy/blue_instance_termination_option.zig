const InstanceAction = @import("instance_action.zig").InstanceAction;

/// Information about whether instances in the original environment are
/// terminated when a
/// blue/green deployment is successful. `BlueInstanceTerminationOption` does
/// not
/// apply to Lambda deployments.
pub const BlueInstanceTerminationOption = struct {
    /// The action to take on instances in the original environment after a
    /// successful
    /// blue/green deployment.
    ///
    /// * `TERMINATE`: Instances are terminated after a specified wait
    /// time.
    ///
    /// * `KEEP_ALIVE`: Instances are left running after they are
    /// deregistered from the load balancer and removed from the deployment
    /// group.
    action: ?InstanceAction,

    /// For an Amazon EC2 deployment, the number of minutes to wait after a
    /// successful
    /// blue/green deployment before terminating instances from the original
    /// environment.
    ///
    /// For an Amazon ECS deployment, the number of minutes before deleting the
    /// original (blue) task set. During an Amazon ECS deployment, CodeDeploy shifts
    /// traffic from the original (blue) task set to a replacement (green) task set.
    ///
    /// The maximum setting is 2880 minutes (2 days).
    termination_wait_time_in_minutes: i32 = 0,

    pub const json_field_names = .{
        .action = "action",
        .termination_wait_time_in_minutes = "terminationWaitTimeInMinutes",
    };
};
