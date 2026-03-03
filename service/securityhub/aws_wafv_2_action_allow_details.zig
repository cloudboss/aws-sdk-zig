const AwsWafv2CustomRequestHandlingDetails = @import("aws_wafv_2_custom_request_handling_details.zig").AwsWafv2CustomRequestHandlingDetails;

/// Specifies that WAF should allow the request and optionally defines
/// additional custom handling for the request.
pub const AwsWafv2ActionAllowDetails = struct {
    /// Defines custom handling for the web request. For information about
    /// customizing web requests and responses, see
    /// [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html) in the *WAF Developer Guide.*.
    custom_request_handling: ?AwsWafv2CustomRequestHandlingDetails = null,

    pub const json_field_names = .{
        .custom_request_handling = "CustomRequestHandling",
    };
};
