const CustomHTTPHeader = @import("custom_http_header.zig").CustomHTTPHeader;

/// A custom response to send to the client. You can define a custom response
/// for rule
/// actions and default web ACL actions that are set to BlockAction.
///
/// For information about customizing web requests and responses,
/// see [Customizing web requests and responses in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
/// in the *WAF Developer Guide*.
pub const CustomResponse = struct {
    /// References the response body that you want WAF to return to the web request
    /// client. You can define a custom response for a rule action or a default web
    /// ACL action that
    /// is set to block. To do this, you first define the response body key and
    /// value in the
    /// `CustomResponseBodies` setting for the WebACL or RuleGroup where you want to
    /// use it. Then, in the rule action or web ACL
    /// default action `BlockAction` setting, you reference the response body using
    /// this
    /// key.
    custom_response_body_key: ?[]const u8 = null,

    /// The HTTP status code to return to the client.
    ///
    /// For a list of status codes that you can use in your custom responses, see
    /// [Supported status codes for custom
    /// response](https://docs.aws.amazon.com/waf/latest/developerguide/customizing-the-response-status-codes.html)
    /// in the *WAF Developer Guide*.
    response_code: i32,

    /// The HTTP headers to use in the response. You can specify any header name
    /// except for `content-type`. Duplicate header names are not allowed.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    response_headers: ?[]const CustomHTTPHeader = null,

    pub const json_field_names = .{
        .custom_response_body_key = "CustomResponseBodyKey",
        .response_code = "ResponseCode",
        .response_headers = "ResponseHeaders",
    };
};
