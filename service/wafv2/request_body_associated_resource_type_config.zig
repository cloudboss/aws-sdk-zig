const SizeInspectionLimit = @import("size_inspection_limit.zig").SizeInspectionLimit;

/// Customizes the maximum size of the request body that your protected
/// CloudFront, API Gateway, Amazon Cognito, App Runner, and Verified Access
/// resources forward to WAF for inspection. The default size is 16 KB (16,384
/// bytes). You can change the setting for any of the available resource types.
///
/// You are charged additional fees when your protected resources forward body
/// sizes that are larger than the default. For more information, see [WAF
/// Pricing](http://aws.amazon.com/waf/pricing/).
///
/// Example JSON: ` {
/// "API_GATEWAY": "KB_48",
/// "APP_RUNNER_SERVICE": "KB_32"
/// }`
///
/// For Application Load Balancer and AppSync, the limit is fixed at 8 KB (8,192
/// bytes).
///
/// This is used in the `AssociationConfig` of the web ACL.
pub const RequestBodyAssociatedResourceTypeConfig = struct {
    /// Specifies the maximum size of the web request body component that an
    /// associated CloudFront, API Gateway, Amazon Cognito, App Runner, or Verified
    /// Access resource should send to WAF for inspection. This applies to
    /// statements in the web ACL that inspect the body or JSON body.
    ///
    /// Default: `16 KB (16,384 bytes)`
    default_size_inspection_limit: SizeInspectionLimit,

    pub const json_field_names = .{
        .default_size_inspection_limit = "DefaultSizeInspectionLimit",
    };
};
