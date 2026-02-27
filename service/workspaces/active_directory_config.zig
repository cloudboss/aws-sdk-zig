/// Information about the Active Directory config.
pub const ActiveDirectoryConfig = struct {
    /// The name of the domain.
    domain_name: []const u8,

    /// Indicates the secret ARN on the service account.
    service_account_secret_arn: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .service_account_secret_arn = "ServiceAccountSecretArn",
    };
};
