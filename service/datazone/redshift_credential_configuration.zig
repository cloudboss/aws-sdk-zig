/// The details of the credentials required to access an Amazon Redshift
/// cluster.
pub const RedshiftCredentialConfiguration = struct {
    /// The ARN of a secret manager for an Amazon Redshift cluster.
    secret_manager_arn: []const u8,

    pub const json_field_names = .{
        .secret_manager_arn = "secretManagerArn",
    };
};
