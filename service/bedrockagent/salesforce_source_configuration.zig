const SalesforceAuthType = @import("salesforce_auth_type.zig").SalesforceAuthType;

/// The endpoint information to connect to your Salesforce data source.
pub const SalesforceSourceConfiguration = struct {
    /// The supported authentication type to authenticate and connect to your
    /// Salesforce instance.
    auth_type: SalesforceAuthType,

    /// The Amazon Resource Name of an Secrets Manager secret that stores your
    /// authentication credentials for your Salesforce instance URL. For more
    /// information on the key-value pairs that must be included in your secret,
    /// depending on your authentication type, see [Salesforce connection
    /// configuration](https://docs.aws.amazon.com/bedrock/latest/userguide/salesforce-data-source-connector.html#configuration-salesforce-connector).
    credentials_secret_arn: []const u8,

    /// The Salesforce host URL or instance URL.
    host_url: []const u8,

    pub const json_field_names = .{
        .auth_type = "authType",
        .credentials_secret_arn = "credentialsSecretArn",
        .host_url = "hostUrl",
    };
};
