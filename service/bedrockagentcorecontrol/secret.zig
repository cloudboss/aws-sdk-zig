/// Contains information about a secret in Amazon Web Services Secrets Manager.
pub const Secret = struct {
    /// The Amazon Resource Name (ARN) of the secret in Amazon Web Services Secrets
    /// Manager.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
    };
};
