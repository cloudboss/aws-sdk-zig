/// Configuration options to be applied to the identity pool.
pub const PushSync = struct {
    /// List of SNS platform application ARNs that could be used by clients.
    application_arns: ?[]const []const u8,

    /// A role configured to allow Cognito to call SNS on behalf of the developer.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .application_arns = "ApplicationArns",
        .role_arn = "RoleArn",
    };
};
