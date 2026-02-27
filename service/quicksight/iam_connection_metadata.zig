/// Authentication metadata for IAM-based connections, used for first-party
/// Amazon Web Services service integrations.
pub const IAMConnectionMetadata = struct {
    /// The Amazon Resource Name (ARN) of the IAM role to assume for authentication
    /// with Amazon Web Services services. This IAM role should be in the same
    /// account as Quick Sight.
    role_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
    };
};
