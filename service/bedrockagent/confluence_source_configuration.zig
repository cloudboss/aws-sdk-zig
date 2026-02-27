const ConfluenceAuthType = @import("confluence_auth_type.zig").ConfluenceAuthType;
const ConfluenceHostType = @import("confluence_host_type.zig").ConfluenceHostType;

/// The endpoint information to connect to your Confluence data source.
pub const ConfluenceSourceConfiguration = struct {
    /// The supported authentication type to authenticate and connect to your
    /// Confluence instance.
    auth_type: ConfluenceAuthType,

    /// The Amazon Resource Name of an Secrets Manager secret that stores your
    /// authentication credentials for your Confluence instance URL. For more
    /// information on the key-value pairs that must be included in your secret,
    /// depending on your authentication type, see [Confluence connection
    /// configuration](https://docs.aws.amazon.com/bedrock/latest/userguide/confluence-data-source-connector.html#configuration-confluence-connector).
    credentials_secret_arn: []const u8,

    /// The supported host type, whether online/cloud or server/on-premises.
    host_type: ConfluenceHostType,

    /// The Confluence host URL or instance URL.
    host_url: []const u8,

    pub const json_field_names = .{
        .auth_type = "authType",
        .credentials_secret_arn = "credentialsSecretArn",
        .host_type = "hostType",
        .host_url = "hostUrl",
    };
};
