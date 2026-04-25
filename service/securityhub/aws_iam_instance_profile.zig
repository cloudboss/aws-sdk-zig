const AwsIamInstanceProfileRole = @import("aws_iam_instance_profile_role.zig").AwsIamInstanceProfileRole;

/// Information about an instance profile.
pub const AwsIamInstanceProfile = struct {
    /// The ARN of the instance profile.
    arn: ?[]const u8 = null,

    /// Indicates when the instance profile was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// The identifier of the instance profile.
    instance_profile_id: ?[]const u8 = null,

    /// The name of the instance profile.
    instance_profile_name: ?[]const u8 = null,

    /// The path to the instance profile.
    path: ?[]const u8 = null,

    /// The roles associated with the instance profile.
    roles: ?[]const AwsIamInstanceProfileRole = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_date = "CreateDate",
        .instance_profile_id = "InstanceProfileId",
        .instance_profile_name = "InstanceProfileName",
        .path = "Path",
        .roles = "Roles",
    };
};
