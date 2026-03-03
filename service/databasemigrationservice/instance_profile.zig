/// Provides information that defines an instance profile.
pub const InstanceProfile = struct {
    /// The Availability Zone where the instance profile runs.
    availability_zone: ?[]const u8 = null,

    /// A description of the instance profile. Descriptions can have up to 31
    /// characters.
    /// A description can contain only ASCII letters, digits, and hyphens ('-').
    /// Also, it can't
    /// end with a hyphen or contain two consecutive hyphens, and can only begin
    /// with a letter.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) string that uniquely identifies the instance
    /// profile.
    instance_profile_arn: ?[]const u8 = null,

    /// The time the instance profile was created.
    instance_profile_creation_time: ?i64 = null,

    /// The user-friendly name for the instance profile.
    instance_profile_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key that is used to encrypt
    /// the connection parameters for the instance profile.
    ///
    /// If you don't specify a value for the `KmsKeyArn` parameter, then
    /// DMS uses an Amazon Web Services owned encryption key to encrypt your
    /// resources.
    kms_key_arn: ?[]const u8 = null,

    /// Specifies the network type for the instance profile. A value of `IPV4`
    /// represents an instance profile with IPv4 network type and only supports IPv4
    /// addressing.
    /// A value of `IPV6` represents an instance profile with IPv6 network type
    /// and only supports IPv6 addressing. A value of `DUAL` represents an instance
    /// profile with dual network type that supports IPv4 and IPv6 addressing.
    network_type: ?[]const u8 = null,

    /// Specifies the accessibility options for the instance profile. A value of
    /// `true` represents an instance profile with a public IP address. A value of
    /// `false` represents an instance profile with a private IP address. The
    /// default value
    /// is `true`.
    publicly_accessible: ?bool = null,

    /// The identifier of the subnet group that is associated with the instance
    /// profile.
    subnet_group_identifier: ?[]const u8 = null,

    /// The VPC security groups that are used with the instance profile.
    /// The VPC security group must work with the VPC containing the instance
    /// profile.
    vpc_security_groups: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .description = "Description",
        .instance_profile_arn = "InstanceProfileArn",
        .instance_profile_creation_time = "InstanceProfileCreationTime",
        .instance_profile_name = "InstanceProfileName",
        .kms_key_arn = "KmsKeyArn",
        .network_type = "NetworkType",
        .publicly_accessible = "PubliclyAccessible",
        .subnet_group_identifier = "SubnetGroupIdentifier",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
