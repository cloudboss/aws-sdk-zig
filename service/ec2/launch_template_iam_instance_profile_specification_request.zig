/// An IAM instance profile.
pub const LaunchTemplateIamInstanceProfileSpecificationRequest = struct {
    /// The Amazon Resource Name (ARN) of the instance profile.
    arn: ?[]const u8,

    /// The name of the instance profile.
    name: ?[]const u8,
};
