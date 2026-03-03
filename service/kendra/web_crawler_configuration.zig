const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const Urls = @import("urls.zig").Urls;

/// Provides the configuration information required for Amazon Kendra Web
/// Crawler.
pub const WebCrawlerConfiguration = struct {
    /// Configuration information required to connect to websites using
    /// authentication.
    ///
    /// You can connect to websites using basic authentication of user name and
    /// password. You
    /// use a secret in [Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html) to
    /// store your authentication credentials.
    ///
    /// You must provide the website host name and port number. For example, the
    /// host name of
    /// https://a.example.com/page1.html is "a.example.com" and the port is 443, the
    /// standard
    /// port for HTTPS.
    authentication_configuration: ?AuthenticationConfiguration = null,

    /// The 'depth' or number of levels from the seed level to crawl. For example,
    /// the seed
    /// URL page is depth 1 and any hyperlinks on this page that are also crawled
    /// are depth 2.
    crawl_depth: ?i32 = null,

    /// The maximum size (in MB) of a web page or attachment to crawl.
    ///
    /// Files larger than this size (in MB) are skipped/not crawled.
    ///
    /// The default maximum size of a web page or attachment is set to 50 MB.
    max_content_size_per_page_in_mega_bytes: ?f32 = null,

    /// The maximum number of URLs on a web page to include when crawling a website.
    /// This
    /// number is per web page.
    ///
    /// As a website’s web pages are crawled, any URLs the web pages link to are
    /// also crawled.
    /// URLs on a web page are crawled in order of appearance.
    ///
    /// The default maximum links per page is 100.
    max_links_per_page: ?i32 = null,

    /// The maximum number of URLs crawled per website host per minute.
    ///
    /// A minimum of one URL is required.
    ///
    /// The default maximum number of URLs crawled per website host per minute is
    /// 300.
    max_urls_per_minute_crawl_rate: ?i32 = null,

    /// Configuration information required to connect to your internal websites via
    /// a web
    /// proxy.
    ///
    /// You must provide the website host name and port number. For example, the
    /// host name of
    /// https://a.example.com/page1.html is "a.example.com" and the port is 443, the
    /// standard
    /// port for HTTPS.
    ///
    /// Web proxy credentials are optional and you can use them to connect to a web
    /// proxy
    /// server that requires basic authentication. To store web proxy credentials,
    /// you use a
    /// secret in [Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html).
    proxy_configuration: ?ProxyConfiguration = null,

    /// A list of regular expression patterns to exclude certain URLs to crawl. URLs
    /// that
    /// match the patterns are excluded from the index. URLs that don't match the
    /// patterns are
    /// included in the index. If a URL matches both an inclusion and exclusion
    /// pattern, the
    /// exclusion pattern takes precedence and the URL file isn't included in the
    /// index.
    url_exclusion_patterns: ?[]const []const u8 = null,

    /// A list of regular expression patterns to include certain URLs to crawl. URLs
    /// that
    /// match the patterns are included in the index. URLs that don't match the
    /// patterns are
    /// excluded from the index. If a URL matches both an inclusion and exclusion
    /// pattern, the
    /// exclusion pattern takes precedence and the URL file isn't included in the
    /// index.
    url_inclusion_patterns: ?[]const []const u8 = null,

    /// Specifies the seed or starting point URLs of the websites or the sitemap
    /// URLs of the
    /// websites you want to crawl.
    ///
    /// You can include website subdomains. You can list up to 100 seed URLs and up
    /// to three
    /// sitemap URLs.
    ///
    /// You can only crawl websites that use the secure communication protocol,
    /// Hypertext
    /// Transfer Protocol Secure (HTTPS). If you receive an error when crawling a
    /// website, it
    /// could be that the website is blocked from crawling.
    ///
    /// *When selecting websites to index, you must adhere to the [Amazon Acceptable
    /// Use Policy](https://aws.amazon.com/aup/) and all
    /// other Amazon terms. Remember that you must only use Amazon Kendra Web
    /// Crawler
    /// to index your own web pages, or web pages that you have authorization to
    /// index.*
    urls: Urls,

    pub const json_field_names = .{
        .authentication_configuration = "AuthenticationConfiguration",
        .crawl_depth = "CrawlDepth",
        .max_content_size_per_page_in_mega_bytes = "MaxContentSizePerPageInMegaBytes",
        .max_links_per_page = "MaxLinksPerPage",
        .max_urls_per_minute_crawl_rate = "MaxUrlsPerMinuteCrawlRate",
        .proxy_configuration = "ProxyConfiguration",
        .url_exclusion_patterns = "UrlExclusionPatterns",
        .url_inclusion_patterns = "UrlInclusionPatterns",
        .urls = "Urls",
    };
};
