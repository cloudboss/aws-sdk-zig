const CustomRequestHandling = @import("custom_request_handling.zig").CustomRequestHandling;

/// Specifies that WAF should allow the request and optionally defines
/// additional
/// custom handling for the request.
///
/// This is used in the context of other settings, for example to specify values
/// for RuleAction and web ACL DefaultAction.
pub const AllowAction = struct {
    /// Defines custom handling for the web request.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    custom_request_handling: ?CustomRequestHandling,

    pub const json_field_names = .{
        .custom_request_handling = "CustomRequestHandling",
    };
};
