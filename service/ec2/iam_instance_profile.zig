/// Describes an IAM instance profile.
pub const IamInstanceProfile = struct {
    /// The Amazon Resource Name (ARN) of the instance profile.
    arn: ?[]const u8,

    /// The ID of the instance profile.
    id: ?[]const u8,
};
