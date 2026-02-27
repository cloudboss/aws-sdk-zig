const SharePointAuthType = @import("share_point_auth_type.zig").SharePointAuthType;
const SharePointHostType = @import("share_point_host_type.zig").SharePointHostType;

/// The endpoint information to connect to your SharePoint data source.
pub const SharePointSourceConfiguration = struct {
    /// The supported authentication type to authenticate and connect to your
    /// SharePoint site/sites.
    auth_type: SharePointAuthType,

    /// The Amazon Resource Name of an Secrets Manager secret that stores your
    /// authentication credentials for your SharePoint site/sites. For more
    /// information on the key-value pairs that must be included in your secret,
    /// depending on your authentication type, see [SharePoint connection
    /// configuration](https://docs.aws.amazon.com/bedrock/latest/userguide/sharepoint-data-source-connector.html#configuration-sharepoint-connector).
    credentials_secret_arn: []const u8,

    /// The domain of your SharePoint instance or site URL/URLs.
    domain: []const u8,

    /// The supported host type, whether online/cloud or server/on-premises.
    host_type: SharePointHostType,

    /// A list of one or more SharePoint site URLs.
    site_urls: []const []const u8,

    /// The identifier of your Microsoft 365 tenant.
    tenant_id: ?[]const u8,

    pub const json_field_names = .{
        .auth_type = "authType",
        .credentials_secret_arn = "credentialsSecretArn",
        .domain = "domain",
        .host_type = "hostType",
        .site_urls = "siteUrls",
        .tenant_id = "tenantId",
    };
};
