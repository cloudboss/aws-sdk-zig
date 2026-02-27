/// Information about an Auto Scaling group.
pub const AutoScalingGroup = struct {
    /// The name of the launch hook that CodeDeploy installed into the Auto Scaling
    /// group.
    ///
    /// For more information about the launch hook, see [How Amazon EC2 Auto Scaling
    /// works with
    /// CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html#integrations-aws-auto-scaling-behaviors) in the
    /// *CodeDeploy User Guide*.
    hook: ?[]const u8,

    /// The Auto Scaling group name.
    name: ?[]const u8,

    /// The name of the termination hook that CodeDeploy installed into the Auto
    /// Scaling group.
    ///
    /// For more information about the termination hook, see [Enabling termination
    /// deployments during Auto Scaling scale-in
    /// events](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html#integrations-aws-auto-scaling-behaviors-hook-enable) in the
    /// *CodeDeploy User Guide*.
    termination_hook: ?[]const u8,

    pub const json_field_names = .{
        .hook = "hook",
        .name = "name",
        .termination_hook = "terminationHook",
    };
};
