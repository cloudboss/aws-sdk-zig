/// Describes the configuration of an auto scaling group.
pub const AutoScalingGroupsConfiguration = struct {
    /// The names of the auto scaling group.
    auto_scaling_group_names: []const []const u8,

    /// The role ARN of the auto scaling group.
    role_arn: []const u8,

    pub const json_field_names = .{
        .auto_scaling_group_names = "autoScalingGroupNames",
        .role_arn = "roleArn",
    };
};
