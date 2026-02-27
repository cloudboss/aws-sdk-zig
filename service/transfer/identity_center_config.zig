/// A structure that describes the values to use for the IAM Identity Center
/// settings when you create or update a web app.
pub const IdentityCenterConfig = struct {
    /// The Amazon Resource Name (ARN) for the IAM Identity Center used for the web
    /// app.
    instance_arn: ?[]const u8,

    /// The IAM role in IAM Identity Center used for the web app.
    role: ?[]const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .role = "Role",
    };
};
