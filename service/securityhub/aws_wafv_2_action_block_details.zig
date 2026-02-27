const AwsWafv2CustomResponseDetails = @import("aws_wafv_2_custom_response_details.zig").AwsWafv2CustomResponseDetails;

/// Specifies that WAF should block the request and optionally defines
/// additional custom handling for the response to the web request.
pub const AwsWafv2ActionBlockDetails = struct {
    /// Defines a custom response for the web request. For information, see
    /// [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html) in the *WAF Developer Guide.*.
    custom_response: ?AwsWafv2CustomResponseDetails,

    pub const json_field_names = .{
        .custom_response = "CustomResponse",
    };
};
