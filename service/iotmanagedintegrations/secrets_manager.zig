/// Configuration for AWS Secrets Manager, used to securely store and manage
/// sensitive information for connector destinations.
pub const SecretsManager = struct {
    /// The Amazon Resource Name (ARN) of the AWS Secrets Manager secret.
    arn: []const u8,

    /// The version ID of the AWS Secrets Manager secret.
    version_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .version_id = "versionId",
    };
};
