const AwsEc2NetworkInterfaceViolation = @import("aws_ec_2_network_interface_violation.zig").AwsEc2NetworkInterfaceViolation;

/// Violation detail for an EC2 instance resource.
pub const AwsEc2InstanceViolation = struct {
    /// Violation detail for network interfaces associated with the EC2 instance.
    aws_ec_2_network_interface_violations: ?[]const AwsEc2NetworkInterfaceViolation,

    /// The resource ID of the EC2 instance.
    violation_target: ?[]const u8,

    pub const json_field_names = .{
        .aws_ec_2_network_interface_violations = "AwsEc2NetworkInterfaceViolations",
        .violation_target = "ViolationTarget",
    };
};
