/// Contains detailed information about the IAM Identity Center configuration
/// for an application.
pub const IdentityCenterDetails = struct {
    /// The ARN of the IAM Identity Center application created for this account
    /// access manager application.
    application_arn: ?[]const u8 = null,

    /// The ARN of the IAM Identity Center instance.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .instance_arn = "instanceArn",
    };
};
