const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;

/// An object representing the resources associated with the node group, such as
/// Auto
/// Scaling groups and security groups for remote access.
pub const NodegroupResources = struct {
    /// The Auto Scaling groups associated with the node group.
    auto_scaling_groups: ?[]const AutoScalingGroup,

    /// The remote access security group associated with the node group. This
    /// security group
    /// controls SSH access to the nodes.
    remote_access_security_group: ?[]const u8,

    pub const json_field_names = .{
        .auto_scaling_groups = "autoScalingGroups",
        .remote_access_security_group = "remoteAccessSecurityGroup",
    };
};
