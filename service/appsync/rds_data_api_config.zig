/// Contains the metadata required to introspect the RDS cluster.
pub const RdsDataApiConfig = struct {
    /// The name of the database in the cluster.
    database_name: []const u8,

    /// The resource ARN of the RDS cluster.
    resource_arn: []const u8,

    /// The secret's ARN that was obtained from Secrets Manager. A secret consists
    /// of secret
    /// information, the secret value, plus metadata about the secret. A secret
    /// value can be a
    /// string or binary. It typically includes the ARN, secret name and
    /// description, policies,
    /// tags, encryption key from the Key Management Service, and key rotation data.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .resource_arn = "resourceArn",
        .secret_arn = "secretArn",
    };
};
