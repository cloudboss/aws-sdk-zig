/// Describes an IAM instance profile for a Scheduled Instance.
pub const ScheduledInstancesIamInstanceProfile = struct {
    /// The Amazon Resource Name (ARN).
    arn: ?[]const u8 = null,

    /// The name.
    name: ?[]const u8 = null,
};
