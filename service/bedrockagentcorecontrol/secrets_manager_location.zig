/// The Amazon Web Services Secrets Manager location configuration.
pub const SecretsManagerLocation = struct {
    /// The ARN of the Amazon Web Services Secrets Manager secret containing the
    /// certificate.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
    };
};
