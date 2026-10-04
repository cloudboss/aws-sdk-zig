/// Describes an IAM instance profile. Supported only for fleets of type
/// `instant`.
pub const FleetIamInstanceProfileSpecificationRequest = struct {
    /// The Amazon Resource Name (ARN) of the instance profile.
    arn: ?[]const u8 = null,

    /// The name of the instance profile.
    name: ?[]const u8 = null,
};
