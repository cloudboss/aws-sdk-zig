/// Provides details for an Identity and Access Management (IAM) instance
/// profile, which is a container for an IAM role for your instance.
pub const AwsEc2LaunchTemplateDataIamInstanceProfileDetails = struct {
    /// The Amazon Resource Name (ARN) of the instance profile.
    arn: ?[]const u8,

    /// The name of the instance profile.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
