/// Details of the Amazon EC2 instance involved in a finding.
pub const AwsEc2InstanceDetails = struct {
    /// The IAM instance profile ARN of the Amazon EC2 instance.
    iam_instance_profile_arn: ?[]const u8,

    /// The image ID of the Amazon EC2 instance.
    image_id: ?[]const u8,

    /// The IPv4 addresses of the Amazon EC2 instance.
    ip_v4_addresses: ?[]const []const u8,

    /// The IPv6 addresses of the Amazon EC2 instance.
    ip_v6_addresses: ?[]const []const u8,

    /// The name of the key pair used to launch the Amazon EC2 instance.
    key_name: ?[]const u8,

    /// The date and time the Amazon EC2 instance was launched at.
    launched_at: ?i64,

    /// The platform of the Amazon EC2 instance.
    platform: ?[]const u8,

    /// The subnet ID of the Amazon EC2 instance.
    subnet_id: ?[]const u8,

    /// The type of the Amazon EC2 instance.
    @"type": ?[]const u8,

    /// The VPC ID of the Amazon EC2 instance.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .iam_instance_profile_arn = "iamInstanceProfileArn",
        .image_id = "imageId",
        .ip_v4_addresses = "ipV4Addresses",
        .ip_v6_addresses = "ipV6Addresses",
        .key_name = "keyName",
        .launched_at = "launchedAt",
        .platform = "platform",
        .subnet_id = "subnetId",
        .@"type" = "type",
        .vpc_id = "vpcId",
    };
};
