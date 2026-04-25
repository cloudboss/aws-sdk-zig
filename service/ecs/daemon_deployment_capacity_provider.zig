/// Information about a capacity provider during a daemon deployment.
pub const DaemonDeploymentCapacityProvider = struct {
    /// The Amazon Resource Name (ARN) of the capacity provider.
    arn: ?[]const u8 = null,

    /// The number of instances being drained on this capacity provider during the
    /// deployment.
    draining_instance_count: ?i32 = null,

    /// The number of instances running daemon tasks on this capacity provider.
    running_instance_count: ?i32 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .draining_instance_count = "drainingInstanceCount",
        .running_instance_count = "runningInstanceCount",
    };
};
