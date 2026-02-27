const AwsWafv2CustomRequestHandlingDetails = @import("aws_wafv_2_custom_request_handling_details.zig").AwsWafv2CustomRequestHandlingDetails;

/// Specifies that WAF should run a CAPTCHA check against the request.
pub const AwsWafv2RulesActionCaptchaDetails = struct {
    /// Defines custom handling for the web request, used when the CAPTCHA
    /// inspection determines that the request's token is valid and unexpired. For
    /// more information,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html) in the *WAF Developer Guide.*.
    custom_request_handling: ?AwsWafv2CustomRequestHandlingDetails,

    pub const json_field_names = .{
        .custom_request_handling = "CustomRequestHandling",
    };
};
