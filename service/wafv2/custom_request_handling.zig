const CustomHTTPHeader = @import("custom_http_header.zig").CustomHTTPHeader;

/// Custom request handling behavior that inserts custom headers into a web
/// request. You can
/// add custom request handling for WAF to use when the rule action doesn't
/// block the request.
/// For example, `CaptchaAction` for requests with valid t okens, and
/// `AllowAction`.
///
/// For information about customizing web requests and responses,
/// see [Customizing web requests and responses in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
/// in the *WAF Developer Guide*.
pub const CustomRequestHandling = struct {
    /// The HTTP headers to insert into the request. Duplicate header names are not
    /// allowed.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    insert_headers: []const CustomHTTPHeader,

    pub const json_field_names = .{
        .insert_headers = "InsertHeaders",
    };
};
