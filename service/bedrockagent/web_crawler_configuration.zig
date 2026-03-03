const WebCrawlerLimits = @import("web_crawler_limits.zig").WebCrawlerLimits;
const WebScopeType = @import("web_scope_type.zig").WebScopeType;

/// The configuration of web URLs that you want to crawl. You should be
/// authorized to crawl the URLs.
pub const WebCrawlerConfiguration = struct {
    /// The configuration of crawl limits for the web URLs.
    crawler_limits: ?WebCrawlerLimits = null,

    /// A list of one or more exclusion regular expression patterns to exclude
    /// certain URLs. If you specify an inclusion and exclusion filter/pattern and
    /// both match a URL, the exclusion filter takes precedence and the web content
    /// of the URL isn’t crawled.
    exclusion_filters: ?[]const []const u8 = null,

    /// A list of one or more inclusion regular expression patterns to include
    /// certain URLs. If you specify an inclusion and exclusion filter/pattern and
    /// both match a URL, the exclusion filter takes precedence and the web content
    /// of the URL isn’t crawled.
    inclusion_filters: ?[]const []const u8 = null,

    /// The scope of what is crawled for your URLs.
    ///
    /// You can choose to crawl only web pages that belong to the same host or
    /// primary domain. For example, only web pages that contain the seed URL
    /// "https://docs.aws.amazon.com/bedrock/latest/userguide/" and no other
    /// domains. You can choose to include sub domains in addition to the host or
    /// primary domain. For example, web pages that contain "aws.amazon.com" can
    /// also include sub domain "docs.aws.amazon.com".
    scope: ?WebScopeType = null,

    /// Returns the user agent suffix for your web crawler.
    user_agent: ?[]const u8 = null,

    /// A string used for identifying the crawler or bot when it accesses a web
    /// server. The user agent header value consists of the `bedrockbot`, UUID, and
    /// a user agent suffix for your crawler (if one is provided). By default, it is
    /// set to `bedrockbot_UUID`. You can optionally append a custom suffix to
    /// `bedrockbot_UUID` to allowlist a specific user agent permitted to access
    /// your source URLs.
    user_agent_header: ?[]const u8 = null,

    pub const json_field_names = .{
        .crawler_limits = "crawlerLimits",
        .exclusion_filters = "exclusionFilters",
        .inclusion_filters = "inclusionFilters",
        .scope = "scope",
        .user_agent = "userAgent",
        .user_agent_header = "userAgentHeader",
    };
};
