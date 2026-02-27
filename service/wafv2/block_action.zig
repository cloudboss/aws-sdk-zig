const CustomResponse = @import("custom_response.zig").CustomResponse;

/// Specifies that WAF should block the request and optionally defines
/// additional
/// custom handling for the response to the web request.
///
/// This is used in the context of other settings, for example to specify values
/// for RuleAction and web ACL DefaultAction.
pub const BlockAction = struct {
    /// Defines a custom response for the web request.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    custom_response: ?CustomResponse,

    pub const json_field_names = .{
        .custom_response = "CustomResponse",
    };
};
