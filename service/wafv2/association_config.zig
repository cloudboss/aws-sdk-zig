const aws = @import("aws");

const RequestBodyAssociatedResourceTypeConfig = @import("request_body_associated_resource_type_config.zig").RequestBodyAssociatedResourceTypeConfig;

/// Specifies custom configurations for the associations between the web ACL and
/// protected resources.
///
/// Use this to customize the maximum size of the request body that your
/// protected resources forward to WAF for inspection. You can
/// customize this setting for CloudFront, API Gateway, Amazon Cognito, App
/// Runner, or Verified Access resources. The default setting is 16 KB (16,384
/// bytes).
///
/// You are charged additional fees when your protected resources forward body
/// sizes that are larger than the default. For more information, see [WAF
/// Pricing](http://aws.amazon.com/waf/pricing/).
///
/// For Application Load Balancer and AppSync, the limit is fixed at 8 KB (8,192
/// bytes).
pub const AssociationConfig = struct {
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
    request_body: ?[]const aws.map.MapEntry(RequestBodyAssociatedResourceTypeConfig),

    pub const json_field_names = .{
        .request_body = "RequestBody",
    };
};
