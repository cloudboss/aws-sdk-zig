const HTTPHeader = @import("http_header.zig").HTTPHeader;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The response from a GetSampledRequests request includes an `HTTPRequest`
/// complex type that
/// appears as `Request` in the response syntax. `HTTPRequest` contains
/// information about
/// one of the web requests that were returned by `GetSampledRequests`.
pub const HTTPRequest = struct {
    /// The IP address that the request originated from. If the `WebACL` is
    /// associated with a CloudFront distribution,
    /// this is the value of one of the following fields in CloudFront access logs:
    ///
    /// * `c-ip`, if the viewer did not use an HTTP proxy or a load balancer to send
    ///   the request
    ///
    /// * `x-forwarded-for`, if the viewer did use an HTTP proxy or a load balancer
    ///   to send the request
    client_ip: ?[]const u8,

    /// The two-letter country code for the country that the request originated
    /// from. For a current list of country codes,
    /// see the Wikipedia entry [ISO 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    country: ?[]const u8,

    /// A complex type that contains two values for each header in the sampled web
    /// request: the name of the header and the value of the header.
    headers: ?[]const HTTPHeader,

    /// The HTTP version specified in the sampled web request, for example,
    /// `HTTP/1.1`.
    http_version: ?[]const u8,

    /// The HTTP method specified in the sampled web request. CloudFront supports
    /// the following methods: `DELETE`,
    /// `GET`, `HEAD`, `OPTIONS`, `PATCH`, `POST`, and `PUT`.
    method: ?[]const u8,

    /// The part of a web request that identifies the resource, for example,
    /// `/images/daily-ad.jpg`.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .client_ip = "ClientIP",
        .country = "Country",
        .headers = "Headers",
        .http_version = "HTTPVersion",
        .method = "Method",
        .uri = "URI",
    };
};
