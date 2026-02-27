const BodyParsingFallbackBehavior = @import("body_parsing_fallback_behavior.zig").BodyParsingFallbackBehavior;
const JsonMatchPattern = @import("json_match_pattern.zig").JsonMatchPattern;
const JsonMatchScope = @import("json_match_scope.zig").JsonMatchScope;
const OversizeHandling = @import("oversize_handling.zig").OversizeHandling;

/// Inspect the body of the web request as JSON. The body immediately follows
/// the request
/// headers.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
///
/// Use the specifications in this object to indicate which parts of the JSON
/// body to
/// inspect using the rule's inspection criteria. WAF inspects only the parts of
/// the JSON
/// that result from the matches that you indicate.
///
/// Example JSON: `"JsonBody": { "MatchPattern": { "All": {} }, "MatchScope":
/// "ALL"
/// }`
///
/// For additional information about this request component option, see [JSON
/// body](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-fields-list.html#waf-rule-statement-request-component-json-body)
/// in the *WAF Developer Guide*.
pub const JsonBody = struct {
    /// What WAF should do if it fails to completely parse the JSON body. The
    /// options are
    /// the following:
    ///
    /// * `EVALUATE_AS_STRING` - Inspect the body as plain text. WAF
    /// applies the text transformations and inspection criteria that you defined
    /// for the
    /// JSON inspection to the body text string.
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement.
    /// WAF applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule
    /// statement.
    ///
    /// If you don't provide this setting, WAF parses and evaluates the content only
    /// up to the
    /// first parsing failure that it encounters.
    ///
    /// WAF parsing doesn't fully validate the input JSON string, so parsing can
    /// succeed even for invalid JSON. When
    /// parsing succeeds, WAF doesn't apply the fallback behavior. For more
    /// information,
    /// see [JSON
    /// body](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-fields-list.html#waf-rule-statement-request-component-json-body)
    /// in the *WAF Developer Guide*.
    invalid_fallback_behavior: ?BodyParsingFallbackBehavior,

    /// The patterns to look for in the JSON body. WAF inspects the results of these
    /// pattern matches against the rule inspection criteria.
    match_pattern: JsonMatchPattern,

    /// The parts of the JSON to match against using the `MatchPattern`. If you
    /// specify `ALL`, WAF matches against keys and values.
    ///
    /// `All` does not require a match to be found in the keys
    /// and a match to be found in the values. It requires a match to be found in
    /// the keys
    /// or the values or both. To require a match in the keys and in the values, use
    /// a logical `AND` statement
    /// to combine two match rules, one that inspects the keys and another that
    /// inspects the values.
    match_scope: JsonMatchScope,

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
    oversize_handling: ?OversizeHandling,

    pub const json_field_names = .{
        .invalid_fallback_behavior = "InvalidFallbackBehavior",
        .match_pattern = "MatchPattern",
        .match_scope = "MatchScope",
        .oversize_handling = "OversizeHandling",
    };
};
