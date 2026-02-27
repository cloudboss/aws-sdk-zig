/// A structure that contains the details of the IAM Identity Center used for
/// your web app. Returned during a call to `DescribeWebApp`.
pub const DescribedIdentityCenterConfig = struct {
    /// The Amazon Resource Name (ARN) for the IAM Identity Center application: this
    /// value is set automatically when you create your web app.
    application_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center used for the web
    /// app.
    instance_arn: ?[]const u8,

    /// The IAM role in IAM Identity Center used for the web app.
    role: ?[]const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .instance_arn = "InstanceArn",
        .role = "Role",
    };
};
