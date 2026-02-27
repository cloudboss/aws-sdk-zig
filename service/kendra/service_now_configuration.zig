const ServiceNowAuthenticationType = @import("service_now_authentication_type.zig").ServiceNowAuthenticationType;
const ServiceNowKnowledgeArticleConfiguration = @import("service_now_knowledge_article_configuration.zig").ServiceNowKnowledgeArticleConfiguration;
const ServiceNowServiceCatalogConfiguration = @import("service_now_service_catalog_configuration.zig").ServiceNowServiceCatalogConfiguration;
const ServiceNowBuildVersionType = @import("service_now_build_version_type.zig").ServiceNowBuildVersionType;

/// Provides the configuration information to connect to ServiceNow as your data
/// source.
pub const ServiceNowConfiguration = struct {
    /// The type of authentication used to connect to the ServiceNow instance. If
    /// you choose
    /// `HTTP_BASIC`, Amazon Kendra is authenticated using the user name and
    /// password provided in the Secrets Manager secret in the `SecretArn`
    /// field. If you choose `OAUTH2`, Amazon Kendra is authenticated using the
    /// credentials of client ID, client secret, user name and password.
    ///
    /// When you use `OAUTH2` authentication, you must generate a token and a
    /// client secret using the ServiceNow console. For more information, see [Using
    /// a
    /// ServiceNow data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-servicenow.html).
    authentication_type: ?ServiceNowAuthenticationType,

    /// The ServiceNow instance that the data source connects to. The host endpoint
    /// should
    /// look like the following: *{instance}.service-now.com.*
    host_url: []const u8,

    /// Configuration information for crawling knowledge articles in the ServiceNow
    /// site.
    knowledge_article_configuration: ?ServiceNowKnowledgeArticleConfiguration,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret that contains
    /// the
    /// user name and password required to connect to the ServiceNow instance. You
    /// can also
    /// provide OAuth authentication credentials of user name, password, client ID,
    /// and client
    /// secret. For more information, see [Using a ServiceNow data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-servicenow.html).
    secret_arn: []const u8,

    /// Configuration information for crawling service catalogs in the ServiceNow
    /// site.
    service_catalog_configuration: ?ServiceNowServiceCatalogConfiguration,

    /// The identifier of the release that the ServiceNow host is running. If the
    /// host is not
    /// running the `LONDON` release, use `OTHERS`.
    service_now_build_version: ServiceNowBuildVersionType,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .host_url = "HostUrl",
        .knowledge_article_configuration = "KnowledgeArticleConfiguration",
        .secret_arn = "SecretArn",
        .service_catalog_configuration = "ServiceCatalogConfiguration",
        .service_now_build_version = "ServiceNowBuildVersion",
    };
};
