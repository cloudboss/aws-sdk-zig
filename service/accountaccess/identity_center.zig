/// Specifies the IAM Identity Center instance to use as the identity source for
/// an application.
pub const IdentityCenter = struct {
    /// The ARN of the IAM Identity Center instance.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "instanceArn",
    };
};
