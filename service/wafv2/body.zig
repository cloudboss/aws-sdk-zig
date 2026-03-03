const OversizeHandling = @import("oversize_handling.zig").OversizeHandling;

/// Inspect the body of the web request. The body immediately follows the
/// request
/// headers.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
pub const Body = struct {
    /// What WAF should do if the body is larger than WAF can inspect.
    ///
    /// WAF does not support inspecting the entire contents of the web request body
    /// if the body
    /// exceeds the limit for the resource type. When a web request body is larger
    /// than the limit, the underlying host service
    /// only forwards the contents that are within the limit to WAF for inspection.
    ///
    /// * For Application Load Balancer and AppSync, the limit is fixed at 8 KB
    ///   (8,192 bytes).
    ///
    /// * For CloudFront, API Gateway, Amazon Cognito, App Runner, and Verified
    ///   Access, the default limit is 16 KB (16,384 bytes), and
    /// you can increase the limit for each resource type in the web ACL
    /// `AssociationConfig`, for additional processing fees.
    ///
    /// * For Amplify, use the CloudFront limit.
    ///
    /// The options for oversize handling are the following:
    ///
    /// * `CONTINUE` - Inspect the available body contents normally, according to
    ///   the rule inspection criteria.
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement. WAF
    /// applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule
    /// statement.
    ///
    /// You can combine the `MATCH` or `NO_MATCH`
    /// settings for oversize handling with your rule and web ACL action settings,
    /// so that you block any request whose body is over the limit.
    ///
    /// Default: `CONTINUE`
    oversize_handling: ?OversizeHandling = null,

    pub const json_field_names = .{
        .oversize_handling = "OversizeHandling",
    };
};
