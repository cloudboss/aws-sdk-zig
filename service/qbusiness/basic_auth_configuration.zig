/// Information about the basic authentication credentials used to configure a
/// plugin.
pub const BasicAuthConfiguration = struct {
    /// The ARN of an IAM role used by Amazon Q Business to access the basic
    /// authentication credentials stored in a Secrets Manager secret.
    role_arn: []const u8,

    /// The ARN of the Secrets Manager secret that stores the basic authentication
    /// credentials used for plugin configuration..
    secret_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .secret_arn = "secretArn",
    };
};
