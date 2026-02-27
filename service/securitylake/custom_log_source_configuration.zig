const CustomLogSourceCrawlerConfiguration = @import("custom_log_source_crawler_configuration.zig").CustomLogSourceCrawlerConfiguration;
const AwsIdentity = @import("aws_identity.zig").AwsIdentity;

/// The configuration used for the third-party custom source.
pub const CustomLogSourceConfiguration = struct {
    /// The configuration used for the Glue Crawler for a third-party custom source.
    crawler_configuration: CustomLogSourceCrawlerConfiguration,

    /// The identity of the log provider for the third-party custom source.
    provider_identity: AwsIdentity,

    pub const json_field_names = .{
        .crawler_configuration = "crawlerConfiguration",
        .provider_identity = "providerIdentity",
    };
};
