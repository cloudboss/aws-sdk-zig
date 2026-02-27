const AwsWafv2CustomHttpHeader = @import("aws_wafv_2_custom_http_header.zig").AwsWafv2CustomHttpHeader;

/// A custom response to send to the client. You can define a custom response
/// for rule actions and default web ACL actions that are set to block.
pub const AwsWafv2CustomResponseDetails = struct {
    /// References the response body that you want WAF to return to the web request
    /// client. You can define a custom response for a rule action or a default web
    /// ACL action that is set to block.
    custom_response_body_key: ?[]const u8,

    /// The HTTP status code to return to the client. For a list of status codes
    /// that you can use in your custom responses, see
    /// [Supported status codes for custom
    /// response](https://docs.aws.amazon.com/waf/latest/developerguide/customizing-the-response-status-codes.html) in the *WAF Developer Guide.*
    response_code: ?i32,

    /// The HTTP headers to use in the response.
    response_headers: ?[]const AwsWafv2CustomHttpHeader,

    pub const json_field_names = .{
        .custom_response_body_key = "CustomResponseBodyKey",
        .response_code = "ResponseCode",
        .response_headers = "ResponseHeaders",
    };
};
