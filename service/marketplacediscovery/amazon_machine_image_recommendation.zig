const AmazonMachineImageSecurityGroup = @import("amazon_machine_image_security_group.zig").AmazonMachineImageSecurityGroup;

/// Recommended instance types for running an AMI fulfillment option.
pub const AmazonMachineImageRecommendation = struct {
    /// The recommended EC2 instance type for this AMI.
    instance_type: []const u8,

    /// The recommended security group configurations for this AMI.
    security_groups: ?[]const AmazonMachineImageSecurityGroup = null,

    pub const json_field_names = .{
        .instance_type = "instanceType",
        .security_groups = "securityGroups",
    };
};
