const ConfluenceAttachmentConfiguration = @import("confluence_attachment_configuration.zig").ConfluenceAttachmentConfiguration;
const ConfluenceAuthenticationType = @import("confluence_authentication_type.zig").ConfluenceAuthenticationType;
const ConfluenceBlogConfiguration = @import("confluence_blog_configuration.zig").ConfluenceBlogConfiguration;
const ConfluencePageConfiguration = @import("confluence_page_configuration.zig").ConfluencePageConfiguration;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const ConfluenceSpaceConfiguration = @import("confluence_space_configuration.zig").ConfluenceSpaceConfiguration;
const ConfluenceVersion = @import("confluence_version.zig").ConfluenceVersion;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Confluence as your data
/// source.
pub const ConfluenceConfiguration = struct {
    /// Configuration information for indexing attachments to Confluence blogs and
    /// pages.
    attachment_configuration: ?ConfluenceAttachmentConfiguration = null,

    /// Whether you want to connect to Confluence using basic authentication of user
    /// name and
    /// password, or a personal access token. You can use a personal access token
    /// for Confluence
    /// Server.
    authentication_type: ?ConfluenceAuthenticationType = null,

    /// Configuration information for indexing Confluence blogs.
    blog_configuration: ?ConfluenceBlogConfiguration = null,

    /// A list of regular expression patterns to exclude certain blog posts, pages,
    /// spaces, or
    /// attachments in your Confluence. Content that matches the patterns are
    /// excluded from the
    /// index. Content that doesn't match the patterns is included in the index. If
    /// content
    /// matches both an inclusion and exclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the content isn't included in the index.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of regular expression patterns to include certain blog posts, pages,
    /// spaces, or
    /// attachments in your Confluence. Content that matches the patterns are
    /// included in the
    /// index. Content that doesn't match the patterns is excluded from the index.
    /// If content
    /// matches both an inclusion and exclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the content isn't included in the index.
    inclusion_patterns: ?[]const []const u8 = null,

    /// Configuration information for indexing Confluence pages.
    page_configuration: ?ConfluencePageConfiguration = null,

    /// Configuration information to connect to your Confluence URL instance via a
    /// web proxy.
    /// You can use this option for Confluence Server.
    ///
    /// You must provide the website host name and port number. For example, the
    /// host name of
    /// *https://a.example.com/page1.html* is "a.example.com" and the
    /// port is 443, the standard port for HTTPS.
    ///
    /// Web proxy credentials are optional and you can use them to connect to a web
    /// proxy
    /// server that requires basic authentication of user name and password. To
    /// store web proxy
    /// credentials, you use a secret in Secrets Manager.
    ///
    /// It is recommended that you follow best security practices when configuring
    /// your web
    /// proxy. This includes setting up throttling, setting up logging and
    /// monitoring, and
    /// applying security patches on a regular basis. If you use your web proxy with
    /// multiple
    /// data sources, sync jobs that occur at the same time could strain the load on
    /// your proxy.
    /// It is recommended you prepare your proxy beforehand for any security and
    /// load
    /// requirements.
    proxy_configuration: ?ProxyConfiguration = null,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// user name and password required to connect to the Confluence instance. If
    /// you use
    /// Confluence Cloud, you use a generated API token as the password.
    ///
    /// You can also provide authentication credentials in the form of a personal
    /// access
    /// token. For more information, see [Using a Confluence data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-confluence.html).
    secret_arn: []const u8,

    /// The URL of your Confluence instance. Use the full URL of the server. For
    /// example,
    /// *https://server.example.com:port/*. You can also use an IP
    /// address, for example, *https://192.168.1.113/*.
    server_url: []const u8,

    /// Configuration information for indexing Confluence spaces.
    space_configuration: ?ConfluenceSpaceConfiguration = null,

    /// The version or the type of Confluence installation to connect to.
    version: ConfluenceVersion,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Confluence.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .attachment_configuration = "AttachmentConfiguration",
        .authentication_type = "AuthenticationType",
        .blog_configuration = "BlogConfiguration",
        .exclusion_patterns = "ExclusionPatterns",
        .inclusion_patterns = "InclusionPatterns",
        .page_configuration = "PageConfiguration",
        .proxy_configuration = "ProxyConfiguration",
        .secret_arn = "SecretArn",
        .server_url = "ServerUrl",
        .space_configuration = "SpaceConfiguration",
        .version = "Version",
        .vpc_configuration = "VpcConfiguration",
    };
};
