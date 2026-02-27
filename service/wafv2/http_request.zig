const HTTPHeader = @import("http_header.zig").HTTPHeader;

/// Part of the response from GetSampledRequests. This is a complex type
/// that appears as `Request` in the response syntax. `HTTPRequest`
/// contains information about one of the web requests.
pub const HTTPRequest = struct {
    /// The IP address that the request originated from. If the web ACL is
    /// associated with a
    /// CloudFront distribution, this is the value of one of the following fields in
    /// CloudFront access
    /// logs:
    ///
    /// * `c-ip`, if the viewer did not use an HTTP proxy or a load balancer to send
    /// the request
    ///
    /// * `x-forwarded-for`, if the viewer did use an HTTP proxy or a load balancer
    /// to send the request
    client_ip: ?[]const u8,

    /// The two-letter country code for the country that the request originated
    /// from. For a
    /// current list of country codes, see the Wikipedia entry [ISO 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    country: ?[]const u8,

    /// A complex type that contains the name and value for each header in the
    /// sampled web
    /// request.
    headers: ?[]const HTTPHeader,

    /// The HTTP version specified in the sampled web request, for example,
    /// `HTTP/1.1`.
    http_version: ?[]const u8,

    /// The HTTP method specified in the sampled web request.
    method: ?[]const u8,

    /// The URI path of the request, which identifies the resource, for example,
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
