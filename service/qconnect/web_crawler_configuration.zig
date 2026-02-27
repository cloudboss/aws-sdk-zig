const WebCrawlerLimits = @import("web_crawler_limits.zig").WebCrawlerLimits;
const WebScopeType = @import("web_scope_type.zig").WebScopeType;
const UrlConfiguration = @import("url_configuration.zig").UrlConfiguration;

/// The configuration details for the web data source.
pub const WebCrawlerConfiguration = struct {
    /// The configuration of crawl limits for the web URLs.
    crawler_limits: ?WebCrawlerLimits,

    /// A list of one or more exclusion regular expression patterns to exclude
    /// certain URLs. If you specify an inclusion and exclusion filter/pattern and
    /// both match a URL, the exclusion filter takes precedence and the web content
    /// of the URL isn’t crawled.
    exclusion_filters: ?[]const []const u8,

    /// A list of one or more inclusion regular expression patterns to include
    /// certain URLs. If you specify an inclusion and exclusion filter/pattern and
    /// both match a URL, the exclusion filter takes precedence and the web content
    /// of the URL isn’t crawled.
    inclusion_filters: ?[]const []const u8,

    /// The scope of what is crawled for your URLs. You can choose to crawl only web
    /// pages that belong to the same host or primary domain. For example, only web
    /// pages that contain the seed URL
    /// `https://docs.aws.amazon.com/bedrock/latest/userguide/` and no other
    /// domains. You can choose to include sub domains in addition to the host or
    /// primary domain. For example, web pages that contain `aws.amazon.com` can
    /// also include sub domain `docs.aws.amazon.com`.
    scope: ?WebScopeType,

    /// The configuration of the URL/URLs for the web content that you want to
    /// crawl. You should be authorized to crawl the URLs.
    url_configuration: UrlConfiguration,

    pub const json_field_names = .{
        .crawler_limits = "crawlerLimits",
        .exclusion_filters = "exclusionFilters",
        .inclusion_filters = "inclusionFilters",
        .scope = "scope",
        .url_configuration = "urlConfiguration",
    };
};
